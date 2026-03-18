module;

import cpp

import semmle.code.cpp.controlflow.ControlFlowGraph
import semmle.code.cpp.controlflow.Dominance

import semmle.code.cpp.commons.Synchronization
import semmle.code.cpp.dataflow.DataFlow

/**
 * Predicate: a strictly happens-before b in program order
 */
predicate programOrder(Expr a, Expr b) {
    strictlyDominates(a, b)
}

predicate programOrder1(Expr a, Expr b) {
   a != b and
  (
    successors_extended(a, b)  // direct successor
    or
    exists(ControlFlowNode c |
      successors_extended(a, c) and
      programOrder1(c, b)
    )
  )
}