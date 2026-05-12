import cpp

import Mutex
import Atomic
import ConflictingAccess
import Heuristic

// Predicate to restrict analysis to project files

predicate unprotectedFieldRace(Field f, FieldAccess a1, FieldAccess a2) {
  //inProjectFile(a1) and
  //inProjectFile(a2) and

  conflictingAccess(f, a1, a2) and

  ( not isAtomicField(f) and
   not bothProtectedBySameMutex(a1, a2))
}

from Type t, Field field, FieldAccess fa1, FieldAccess fa2
where
  inProjectFile(fa1) and
  inProjectFile(fa2) and

  hasMutexOrAtomic(t) and
  
  field.getDeclaringType() = t and
  fa1.getTarget() = field and
  fa2.getTarget() = field and

  fa1.getEnclosingFunction().getDeclaringType() = t and
  fa2.getEnclosingFunction().getDeclaringType() = t and

  unprotectedFieldRace(field, fa1, fa2)
select t, field.getName(), fa1, fa2, "G3 violation: conflicting accesses to shared field without synchronization (potential data race)."