import cpp



// Two accesses that are conflicting
from Variable var, VariableAccess a1, VariableAccess a2
where
  a1.getTarget() = var and
  a2.getTarget() = var and
  a1 != a2 and
  (
    a1.isModified() or a2.isModified() // at least one write
  )
select var, a1, a2