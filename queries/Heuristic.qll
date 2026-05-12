module;

import cpp

predicate inProjectFile(Element e) {
  e.getFile().getAbsolutePath().matches("%/external/ccia_code_samples/%")
}

//getFile().FromSource()

predicate hasClass(File f){
  exists(Class c | c.getFile() = f)
}

predicate hasMutexOrAtomic(Type t) {
  exists(Include inc |
    inc.getFile() = t.getFile() and
    (
       inc.getIncludedFile().getBaseName() = "mutex" or
      inc.getIncludedFile().getBaseName() = "atomic"
    )
  )
}