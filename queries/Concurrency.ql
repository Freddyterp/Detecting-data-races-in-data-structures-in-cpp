import cpp

import semmle.code.cpp.controlflow.ControlFlowGraph
import semmle.code.cpp.controlflow.Dominance

import semmle.code.cpp.commons.Synchronization
import semmle.code.cpp.dataflow.DataFlow

/**
 * Predicate: a strictly happens-before b in program order
 */
predicate programOrder(Expr a, Expr b) {
  exists(Function f |
    f = a.getEnclosingFunction() and
    f = b.getEnclosingFunction() and
    strictlyDominates(a, b)
  )
}

predicate mutexRule(Expr a, Expr b) {
    exists(Call unlock, Call lock, Expr mutexObj) {
        a = unlock and
        unlockCall(unlock, mutexObj) and
        b = lock and
        lockCall(lock, mutexObj) and
        a.getEnclosingFunction() = b.getEnclosingFunction() and 
        a.getCfgNode().precedes(b.getCfgNode())
    }
}