module;

import cpp

import semmle.code.cpp.controlflow.ControlFlowGraph
import semmle.code.cpp.controlflow.Dominance



/**
 * Predicate: a strictly happens-before b in program order
 */
predicate programOrder(Expr a, Expr b) {
    strictlyDominates(a, b)
}