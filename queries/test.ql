import cpp

from IfStmt ifstmt, BlockStmt blockstmt
where ifstmt.getThen() = blockstmt and
      blockstmt.getNumStmt() = 0
select ifstmt, "This if statement has an empty then block."