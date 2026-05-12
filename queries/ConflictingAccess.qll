module;

import cpp

predicate conflictingAccess(Field f, FieldAccess a1, FieldAccess a2) {
  a1.getTarget() = f and
  a2.getTarget() = f and
  a1 != a2 and

  (a1.isModified() or a2.isModified()) and
   a1.getEnclosingFunction().getDeclaringType() = a2.getEnclosingFunction().getDeclaringType() and

  (a1.getLocation().getStartLine() < a2.getLocation().getStartLine() or
   (a1.getLocation().getStartLine() = a2.getLocation().getStartLine() and
    a1.getLocation().getStartColumn() < a2.getLocation().getStartColumn()))
}