# PARSER PROJECT - CS 4450

---

## Group member: 
  Kylee Willis (kwcnr)
  
    (Contribution amount - 100/100 :) )
    
## EXPLANATION
"Python.g4" is the grammar file upon which I ran ANTLR.
  
My project attempts to create a parse tree from python_test_code.py. Frankly, I have no idea how well it works, because I can't figure out how to run it, but each individual line I've tested works. Most of the grammar I wrote can be used on any Python 3 file, I think, but some of it is specific to the test code because I couldn't figure out how to work around that.
  

## SETUP / ENVIRONMENTAL STEPS
For setup... *(I'm on Windows.)*
- Install Java (make sure the JDK gets installed)
  - I downloaded the latest version from Oracle.
  - To be honest, I didn't set up the JDK myself; I opened a Java file in Visual Studio Code and it popped up with a notice that I needed to install a JDK.
  - I made sure the Java file that was created in the installation got added to my Path variable.
- Deal with ANTLR
  - Download ANTLR (I downloaded the 4.9.2 release, as that was what was linked in the pdf from class.)
  - Create antlr4.bat for easier use of ANTLR (one line: `java org.antlr.v4.Tool %*`)
  - Create grun.bat for easier testing (one line: `java org.antlr.v4.gui.TestingRig %*`)
  - Place these files (ANTLR, antlr4.bat, grun.bat) somewhere they won't get lost.
  - Add their location to `Path`.
  - Create a new system environmental variable named `CLASSPATH` - `.;[absolute path to the antlr .jar file];%CLASSPATH%`.
- For testing, I used Command Prompt.
  - antlr4 (name).g4
  - javac (name)*.java
  - grun (name) (rule) (test file) -gui

## HOW TO RUN
Honestly? I tested pretty much the whole thing using the grun.bat file; unfortunately, I couldn't get a handler running. Because of this, I'm not sure how it would run; the root of the tree is usually the first parser rule, but here, that's `comment`, and a comment does not the root of a tree make.

**I'd say run it with the root as `ifs`**, since there are a lot of them and a lot of them are nested. If multiple calls are necessary, continue down the line; `whiles` and `fors` would be next, then `varhandle`, `arithmetic`, `conditional`, and `print`. (Neither `cast` nor `string` need be called.)



Actually running on the whole file would, I think, require one to import the lexer and parser created by ANTLR and import ANTLR's runtime stuff. From there, one would open the test file `python_test_code.py` as a character stream, load that into the lexer, load that into some tokens, and load the tokens into the parser. A tree would then be generated based on a specified rule (e.g. "comment" or "variable" in my code). A listener or visitor would need to be created, but then a walker would walk through the tree using the listener or visitor.

TLDR; you'd need a script to call the lexer and parser created upon the test file.

## DEMO
https://youtu.be/T2lkFJEIefM - can't submit a link on the Parser Project page, for some reason.

---
---
---

### OF TRIALS AND TRIBULATIONS, if you're interested in that sort of thing
- Attempting to parse "range(2, int(num/2)+2)" is absolutely brutal. I've separated out arithmetic and casting, but I can't seem to find a way to prevent them from cross referencing with this specific line; there's arithmetic inside, so that needs to be handled, then casting,then another set of arithmetic. So arithmetic has to reference casting which has to reference arithmetic and now my grammar hates me. I eventually gave up and parsed the exact phrase, which I'm sure is not what I was supposed to do, but I can't figure out how else that might work.
- Arithmetic doesn't work when I allow for concatenation in a variable assignment/declaration??? Regardless of how I move everything; regardless of the fact that the + is between two strings, or that there's no variable declaration involved, or that arithmetic comes first; it just breaks.
- Yeah, so to follow up about concatenation, nothing I have managed to figure out in the hour I've been trying has fixed it. I gave up and added specific formats to "caststr". It seems that if I add a + by itself anywhere outside of arithmetic, it refuses to ever be arithmetic again.
- Also, there's no... points for casts or prints, despite how many times they show up in python_test_code.py - was it necessary to do all this, or could I have parsed specific strings from the beginning??
- How... do I run this on a file? I've tested it with individual lines, but I can't see how indention works without testing the file.
- *Indentations* \*angry hiss\*
