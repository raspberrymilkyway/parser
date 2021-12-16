# PARSER PROJECT - CS 4450


## Group member: 
  Kylee Willis (kwcnr)
  
    (Contribution amount - 100/100 :) )
    
## SETUP / ENVIRONMENTAL STEPS
????

## HOW TO RUN
I have no idea.

---
### HOW I TESTED INDIVIDUAL LINES, BECAUSE I KNOW THAT I WILL FORGET
- antlr4 (name).g4
- javac (name)*.java
- type test.py | grun (name) (rule) -gui

### OF TRIALS AND TRIBULATIONS, if you're interested in that sort of thing
- Attempting to parse "range(2, int(num/2)+2)" is absolutely brutal. I've separated out arithmetic and casting, but I can't seem to find a way to prevent them from cross referencing with this specific line; there's arithmetic inside, so that needs to be handled, then casting,then another set of arithmetic. So arithmetic has to reference casting which has to reference arithmetic and now my grammar hates me. I eventually gave up and parsed the exact phrase, which I'm sure is not what I was supposed to do, but I can't figure out how else that might work.
- Arithmetic doesn't work when I allow for concatenation in a variable assignment/declaration??? Regardless of how I move everything; regardless of the fact that the + is between two strings, or that there's no variable declaration involved, or that arithmetic comes first; it just breaks.
- Yeah so to follow up about concatenation, nothing I have managed to figure out in the hour I've been trying has fixed it. I gave up and added specific formats to "caststr". It seems that if I add a + by itself anywhere outside of arithmetic, it refuses to ever be arithmetic again.
- Also, there's no... points for casts or prints, despite how many times they show up in python_test_code.py - was it necessary to do all this, or could I have parsed specific strings from the beginning??
- How... do I run this on a file? I've tested it with individual lines, but I can't see how indention works without testing the file.
- *Indentions* \*angry hiss\*
