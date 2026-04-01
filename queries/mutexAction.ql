import cpp

predicate isLocked(Call call, Expr mutex) {
    (call instanceof ConstructorCall and
     call.getTarget().getDeclaringType().getName().matches("%lock_guard%") and
     mutex = call.getArgument(0)) or 

    // Direct mutex.lock() method call
    (call.getTarget() instanceof MemberFunction and
     call.getTarget().getName() = "lock" and
     mutex = call.getQualifier())
}

predicate isUnlocked(Call call, Expr mutex) {
  // RAII: lock_guard destructor
    (call instanceof DestructorCall and
    call.getTarget().getDeclaringType().getName().matches("%lock_guard%") and
    unlockMutex(call, mutex)) or 
    (call.getTarget() instanceof MemberFunction and
    call.getTarget().getName() = "unlock" and
    mutex = call.getQualifier())
}


predicate unlockMutex(DestructorCall dtor, Expr mutex) {
    exists(Variable v, Initializer init, ConstructorCall ctor |
        v.getAnAccess() = dtor.getQualifier() and
        init = v.getInitializer() and
        ctor = init.getExpr().(ConstructorCall) and
        mutex = ctor.getArgument(0))
}


/**
 * Test query for isLocked / isUnlocked predicates
 */
/*from Call c, Expr m
where isLocked(c, m)
select c, m, "This call locks the mutex"*/

from Call c, Expr m
where isUnlocked(c, m) and
    c.getLocation().getFile().getRelativePath().matches("%mutex.cpp%")
select c, m, "This call unlocks the mutex"