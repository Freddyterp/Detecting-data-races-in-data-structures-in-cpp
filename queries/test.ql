import cpp

import Concurrency

from Expr a, Expr b
where
  a != b and
  programOrder(a, b) and
    a.getLocation().getFile().getRelativePath().matches("%happensBefore.cpp%") and
    b.getLocation().getFile().getRelativePath().matches("%happensBefore.cpp%")

select a, b, "Call `a` happens before call `b` according to programOrder"