import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import static org.antlr.v4.runtime.CharStreams.fromFileName;

public class launch{
public static void main(String[] args) {

    CharStream cs = fromFileName("python_test_code.py");  //load the file
    TestLexer lexer = new TestLexer(cs);  //instantiate a lexer
    CommonTokenStream tokens = new CommonTokenStream(lexer); //scan stream for tokens
    TestParser parser = new TestParser(tokens);  //parse the tokens

    ParseTree tree = parser.comment(); // parse the content and get the tree
    Mylistener listener = new Mylistener();

    ParseTreeWalker walker = new ParseTreeWalker();
    walker.walk(listener,tree);
}}