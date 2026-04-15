module;

import cpp

import semmle.code.cpp.controlflow.ControlFlowGraph
import semmle.code.cpp.controlflow.Dominance

predicate isLocked(Call call, Variable mutex) {
    ( exists (VariableAccess va |
      call instanceof ConstructorCall and
      call.getTarget().getDeclaringType().getName().matches("%lock_guard%") and
      va = call.getQualifier() and
      mutex = va.getTarget() and
      mutex.getType().hasName("mutex")
    )) or

    // Direct mutex.lock() method call
    ( exists(VariableAccess va |
      call.getTarget() instanceof MemberFunction and
      call.getTarget().getName() = "lock" and
      va = call.getQualifier() and
      mutex = va.getTarget() and
      mutex.getType().hasName("mutex")
    ))
}

predicate isUnlocked(Call call, Variable mutex) {
  // RAII: lock_guard destructor
    (call instanceof DestructorCall and
    call.getTarget().getDeclaringType().getName().matches("%lock_guard%") and
    unlockMutex(call, mutex)) or
    (exists(VariableAccess va |
      call.getTarget() instanceof MemberFunction and
      call.getTarget().getName() = "unlock" and
      va = call.getQualifier() and
      mutex = va.getTarget() and
      mutex.getType().hasName("mutex")
    ))
}


predicate unlockMutex(DestructorCall dtor, Variable mutex) {
  exists(Variable v, Initializer init, ConstructorCall ctor, VariableAccess arg |
    v.getAnAccess() = dtor.getQualifier() and
    init = v.getInitializer() and
    ctor = init.getExpr().(ConstructorCall) and
    arg = ctor.getArgument(0) and
    mutex = arg.getTarget()
  )
}

predicate isProtectedBy(Expr access, Variable mutexVar) {
  exists(Call lockCall, Call unlockCall |
    isLocked(lockCall, mutexVar) and
    isUnlocked(unlockCall, mutexVar) and
    lockCall.getEnclosingFunction() = access.getEnclosingFunction() and
    lockCall.getLocation().getStartLine() < access.getLocation().getStartLine() and
    access.getLocation().getStartLine() < unlockCall.getLocation().getStartLine()
  )
}

predicate bothProtectedBySameMutex(Expr a1, Expr a2) {
  exists(Variable mutexVar | 
    isProtectedBy(a1, mutexVar) and
    isProtectedBy(a2, mutexVar)
  )
}