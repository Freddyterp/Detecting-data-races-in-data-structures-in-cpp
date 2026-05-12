import cpp
import Mutex

/*from Call call, Field mutex
where 
  call.getFile().getAbsolutePath().matches("%conflictingWithOneLock.cpp%") and
  isUnlocked(call, mutex)
select call, call.getLocation(), mutex.getName(), "Unlock detected"*/


/*from Call call, Field mutex
where 
  call.getFile().getAbsolutePath().matches("%conflictingWithOneLock.cpp%") and
  isLocked(call, mutex)
select call, call.getLocation(), mutex.getName(), "Lock detected"*/


/*from FieldAccess access, Field mutex, Call lockCall, Call unlockCall
where 
  access.getFile().getAbsolutePath().matches("%conflictingWithOneLock.cpp%") and
  access.getTarget().getName() = "value" and
  access.getEnclosingFunction().getName() = "getValue" and
  isLocked(lockCall, mutex) and
  isUnlocked(unlockCall, mutex) and
  lockCall.getEnclosingFunction().getDeclaringType() = access.getEnclosingFunction().getDeclaringType() and
  unlockCall.getEnclosingFunction().getDeclaringType() = access.getEnclosingFunction().getDeclaringType() and
  lockCall.getLocation().getStartLine() < access.getLocation().getStartLine() and
  access.getLocation().getStartLine() < unlockCall.getLocation().getStartLine()
select access.getLocation(), lockCall, lockCall.getLocation(), lockCall.getEnclosingFunction().getDeclaringType(), 
       unlockCall, unlockCall.getLocation(), unlockCall.getEnclosingFunction().getDeclaringType(), "Protection details"*/


/*from FieldAccess access, Field mutex
where 
  access.getFile().getAbsolutePath().matches("%conflictingWithOneLock.cpp%") and
  access.getTarget().getName() = "value" and
  access.getEnclosingFunction().getName() = "getValue" and
  isProtectedBy(access, mutex)
select access, access.getLocation(), mutex.getName(), "Still showing as protected"*/

/*import Atomic

from Field f
where 
  f.getFile().getAbsolutePath().matches("%conflictingWithAtomic.cpp%") and
  isAtomicField(f)
select f, f.getType(), f.getType().getUnspecifiedType(), f.getType().getUnspecifiedType().(Class).getQualifiedName()*/

from Expr e
where
  e.getFile().fromSource()
select e, e.getFile(), e.getLocation(), "Testing file filtering"
