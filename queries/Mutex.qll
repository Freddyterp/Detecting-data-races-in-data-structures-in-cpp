module;

import cpp

import semmle.code.cpp.controlflow.ControlFlowGraph
import semmle.code.cpp.controlflow.Dominance

predicate isLocked(Call call, Field mutex) {
    ( exists (FieldAccess fa |
      call instanceof ConstructorCall and
      call.getTarget().getDeclaringType().getName().matches("%lock_guard%") and
      fa = call.getArgument(0) and
      mutex = fa.getTarget() and
      mutex.getType().hasName("mutex")
    )) or

    // Direct mutex.lock() method call
    ( exists(FieldAccess fa |
      call.getTarget() instanceof MemberFunction and
      call.getTarget().getName() = "lock" and
      fa = call.getQualifier() and
      mutex = fa.getTarget() and
      mutex.getType().hasName("mutex")
    ))
}

predicate isUnlocked(Call call, Field mutex) {
  // RAII: lock_guard destructor
    (call instanceof DestructorCall and
    call.getTarget().getDeclaringType().getName().matches("%lock_guard%") and
    unlockMutex(call, mutex)) or
    (exists(FieldAccess va |
      call.getTarget() instanceof MemberFunction and
      call.getTarget().getName() = "unlock" and
      va = call.getQualifier() and
      mutex = va.getTarget() and
      mutex.getType().hasName("mutex")
    ))
}


predicate unlockMutex(DestructorCall dtor, Field mutex) {
  exists(Variable v, Initializer init, ConstructorCall ctor, FieldAccess arg |
    v.getAnAccess() = dtor.getQualifier() and
    init = v.getInitializer() and
    ctor = init.getExpr().(ConstructorCall) and
    arg = ctor.getArgument(0) and
    mutex = arg.getTarget()
  )
}

predicate isProtectedBy(FieldAccess access, Field mutex) {
  exists(Call lockCall, Call unlockCall |
    isLocked(lockCall, mutex) and
    isUnlocked(unlockCall, mutex) and
    
    lockCall.getEnclosingFunction() = access.getEnclosingFunction() and
    unlockCall.getEnclosingFunction() = access.getEnclosingFunction() and

    lockCall.getLocation().getStartLine() < access.getLocation().getStartLine() and
    access.getLocation().getStartLine() < unlockCall.getLocation().getStartLine() and

    lockCall.getLocation().getStartLine() < unlockCall.getLocation().getStartLine()
  )
}

predicate bothProtectedBySameMutex(FieldAccess a1, FieldAccess a2) {
  exists(Field mutex |
    isProtectedBy(a1, mutex) and
    isProtectedBy(a2, mutex)
  )
}