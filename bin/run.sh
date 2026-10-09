#!/bin/bash
# usage: run.sh <document.lisp> <form>   e.g. run.sh doc.lisp '(rst:check)'
G=${RST_GRAMMAR:-$(cd "$(dirname "$0")/.." && pwd)/grammar.lisp}
J=$HOME/.m2/repository/org/abcl/abcl/1.9.2/abcl-1.9.2.jar
exec java --add-opens java.base/java.lang=ALL-UNNAMED -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 \
  -jar "$J" --noinform --batch --load "$(dirname "$0")/../markdown.lisp" \
  --eval "(rst:load-grammar \"$G\")" --load "$1" --eval "$2"
