import cpp

import Heuristic
import ConflictingAccess

/**
 * Detects potential violations of Guideline 1:
 * unsafe exposure of mutable internal state.
 */

predicate isMutableField(Field f) {
    not f.isConst() and
    not f.getType().hasName("std::atomic")
}

predicate publicMutableField(Field f) {
    f.isPublic() and
    isMutableField(f)
}

predicate escapingFieldReturn(MemberFunction m, Field f) {
    exists(ReturnStmt r, FieldAccess fa, RoutineType ft |
        r.getEnclosingFunction() = m and
        fa = r.getExpr() and
        fa.getTarget() = f and

        ft = m.getType() and
        (
            ft.getReturnType() instanceof ReferenceType or
            ft.getReturnType() instanceof PointerType
        ) and

        isMutableField(f)
    )
}


from Type t, Field f, MemberFunction m
where
    //inProjectFile(f) and
    hasMutexOrAtomic(t) and

    f.getDeclaringType() = t and
    (
        publicMutableField(f)
        or
        escapingFieldReturn(m, f)
    )
select t, f,
  "G1 violation: unsafe exposure of mutable internal state."