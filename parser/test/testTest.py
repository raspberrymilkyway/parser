import antlr4
from antlr4.InputStream import InputStream
from TestLexer import TestLexer
from TestParser import TestParser
import sys

def main():
    input_stream = None
    if len(sys.argv) > 1:
        input_stream = FileStream(sys.argv[1])
    else:
        input_stream = InputStream(sys.stdin.readline())
    lexer = TestLexer(input_stream) 
    stream = antlr4.CommonTokenStream(lexer) 
    parser = TestParser(stream) 
    tree = parser.expression()
    print(tree)
    
if __name__ == '__main__':
    main()

