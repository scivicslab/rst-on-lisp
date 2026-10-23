Examples of how to answer the cases that are easy to get wrong. Each shows part of a section, the lines to write for
it, and why.

1. Three characteristics of one thing are parts of it, not kinds of it.
   Section "4.1.2. Objects", C = object.
   [b2] The object's behavior—what can you do with this object? The object's state—how does the object react when you
   invoke those methods? The object's identity—how is the object distinguished from others?
   Answer:
   b2 | part | behavior
   b2 | part | state
   b2 | part | identity
   Why: you cannot say "behavior is an object"; behavior, state and identity are what every object has.

2. A block that says several things gets a line for each. Do not choose the main one.
   Section "3.2. Comments", C = comment.
   [b1] Comments in Java do not show up in the executable program. Java has three ways of marking comments. The most
   common form is a //. Use this for a comment that runs from the // to the end of the line.
   Answer:
   b1 | aspect | definition
   b1 | kind | end-of-line comment (//)
   Why: the block says what a comment is, and then takes up the // comment, one of the three kinds. Both go into the
   frame of comment: the definition as one of its items, the // comment as one of its kinds.

3. A block about C as a whole is an aspect of C, never a kind of C. Do not write C itself as a kind.
   Section "3.3.1. Integer Types", C = integer type.
   [b1] The integer types are for numbers without fractional parts. Negative values are allowed. Java provides the
   four integer types shown in Table 3.1.
   [b3] | Type | Storage Requirement | Range | ... | byte | 1 byte | ... | short | 2 bytes | ... | int | 4 bytes | ... |
   long | 8 bytes | ...
   Answer:
   b1 | aspect | definition
   b3 | kind | byte
   b3 | kind | short
   b3 | kind | int
   b3 | kind | long
   Why: "integer type is an integer type" says nothing; b1 defines C. Each row of the table is a kind of C.

4. Statements made about C are aspects of C, even when the section lists several of them.
   Section "1.5. Common Misconceptions about Java", C = Java.
   [b2] Java is an extension of HTML. ...
   Answer:
   b2 | aspect | misconception: Java is an extension of HTML
   Why: a misconception about Java is not a kind of Java.

5. A method that acts on C is an operation, not a kind.
   Section "10.6.1. Blocking Queues", C = blocking queue.
   [b4] add, element, offer, peek, poll, put, remove, take ...
   Answer:
   b4 | operation | add
   b4 | operation | offer
   Why: you cannot say "add is a blocking queue"; add is called on one.

6. Events told in the order they happened are steps.
   Section "1.4. A Short History of Java", C = history of Java.
   [b2] In 1991, a group of Sun engineers wanted to design a small computer language for consumer devices ...
   Answer:
   b2 | step | the Green project (1991)
   Why: a history runs in time; each block takes up what happened next.

7. A block that is only an example, a code listing or a figure is left out, always.
   Section "3.2. Comments", [b2] is the code System.out.println("We will not use 'Hello, World!'"); // is this too cute?
   Answer: no line for b2.
