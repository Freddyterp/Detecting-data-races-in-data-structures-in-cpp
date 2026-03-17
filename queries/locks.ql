import cpp

import semmle.code.cpp.threadsafety.ThreadSafety

from ScopeLock sl, Lockable l
where sl.getLockable() = l and
      sl.getThreadSafetyAnnotation().getName() = "GuardedBy" and
      sl.getThreadSafetyAnnotation().getNumArguments() = 1 and
      sl.getThreadSafetyAnnotation().getArgument(0) = l
select sl, "This lockable is guarded by itself, which may lead to deadlocks."