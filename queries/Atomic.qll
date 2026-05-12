module;

import cpp

predicate isAtomicField(Field f) {
  f.getType().getUnspecifiedType().(Class).getQualifiedName().matches("std::atomic<%>")
}