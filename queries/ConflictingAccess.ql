import cpp

import mutexAction

// Predicate to restrict analysis to project files
// Predicate to restrict analysis to project files
predicate inProjectFile(Expr e) {
  e.getFile().getAbsolutePath().matches("%/cppCode/%")
}

predicate hasClass(File f){
  exists(Class c | c.getFile() = f)
}

predicate hasMutexOrAtomic(File f) {
  exists(Include inc |
    inc.getFile() = f and
    (
      inc.getTarget().getName() = "mutex" or
      inc.getTarget().getName() = "atomic"
    )
  )
}

predicate unprotectedFieldRace(Field f, FieldAccess a1, FieldAccess a2) {
  inProjectFile(a1) and
  inProjectFile(a2) and

  a1.getField() = f and
  a2.getField() = f and
  a1 != a2 and

  (a1.isWrite() or a2.isWrite()) and

  not bothProtectedBySameMutex(a1, a2)
}

from File f, Field field, FieldAccess fa1, FieldAccess fa2
where
  hasMutexOrAtomic(f) and
  hasClass(f) and

  field.getFile() = f and
  unprotectedFieldRace(field, fa1, fa2)
select f, fa1, fa2, "This file contains a potential data race"