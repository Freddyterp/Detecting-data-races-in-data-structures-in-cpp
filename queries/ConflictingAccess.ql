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
       inc.getIncludedFile().getBaseName() = "mutex" or
      inc.getIncludedFile().getBaseName() = "atomic"
    )
  )
}

predicate unprotectedFieldRace(Field f, FieldAccess a1, FieldAccess a2) {
  inProjectFile(a1) and
  inProjectFile(a2) and

  a1.getTarget() = f and
  a2.getTarget() = f and
  a1 != a2 and

  (a1.isModified() or a2.isModified()) and

  not bothProtectedBySameMutex(a1, a2)
}

from File f, Field field, FieldAccess fa1, FieldAccess fa2
where
  hasMutexOrAtomic(f) and
  hasClass(f)

  //field.getFile() = f and 
  //unprotectedFieldRace(f, a1, a2)
select f, "this file includes mutex or atomic and has a class"