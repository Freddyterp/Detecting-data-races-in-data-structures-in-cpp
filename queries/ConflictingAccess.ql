import cpp

import mutexAction

// Predicate to restrict analysis to project files
// Predicate to restrict analysis to project files
predicate inProjectFile(Expr e) {
  e.getFile().getAbsolutePath().matches("%/cppCode/%")
}

// Two accesses that are conflicting
from Variable var, VariableAccess a1, VariableAccess a2
where
  // Only project files
  inProjectFile(a1) and
  inProjectFile(a2) and

  // Access the same variable
  a1.getTarget() = var and
  a2.getTarget() = var and
  a1 != a2 and

  // At least one write
  (a1.isModified() or a2.isModified()) and

  //protected by the same mutex
  not bothProtectedBySameMutex(a1, a2)
select var, a1, a2