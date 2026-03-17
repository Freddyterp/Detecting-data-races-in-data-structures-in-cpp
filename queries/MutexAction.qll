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
    (call instanceof DestructorCall and
     call.getTarget().getDeclaringType().getName().matches("%lock_guard%") and
     mutex = call.getArgument(0)) or 

    // Direct mutex.unlock() method call
    (call.getTarget() instanceof MemberFunction and
     call.getTarget().getName() = "unlock" and
     mutex = call.getQualifier())
}