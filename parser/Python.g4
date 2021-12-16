// first parser rules then LEXER ONES
// lexer rules analyzed in order they appear; can be ambiguous
    /*
        ORGANIZE THIS SO COMMENTS COME FIRST. figure out other ambiguities later
        ifelse -> anythingelse -> varname (varname needs to be last)
    */

grammar Python;

//needs to handle if/else, variable definitions, loops, arithmetic, assignments, conditionals, comments, and whitespace
/*
    currently works:
        variable definitions and assignments
        conditional statements (not in anything; just conditionals)
        comments
        whitespace, ish.
        loops and if/else, in terms of recognizing the initial bit
*/


//in an actual parser, comment would need to be more complex. the test file, however, only has comments on their own lines, so I only interpreted that type.
comment
    : COM
    ;

ifs
    : IFELSE '('? (conditional ('and' | 'or')?)+ ')'? ':'
    ;
whiles
    : 'while' '('? (conditional ('and' | 'or')?)+ ')'? ':'
    ;
fors
    : 'for' VARNAME 'in' 'range(' (NUM | VARNAME | arithmetic | cast) ',' (NUM | VARNAME | arithmetic | cast) ')' ':' //for each specifically
    ;

variable
    : VARNAME ASOP (NUM | arithmetic | string | cast)
    ;

arithmetic
    : (VARNAME | NUM | castint) (SIGNS (VARNAME | NUM | castint))+
    ;

conditional
    : (VARNAME | NUM | string) WS* CON WS* (VARNAME | NUM | string)
    ;

//...Do I need this?
print
    : 'print(' (VARNAME | string | caststr | NUM | arithmetic)* ')'
    ;

cast
    : caststr
    | castint
    ;
caststr
    : 'str(' (VARNAME | NUM | arithmetic) ')'
    | '+str(' (VARNAME | NUM | arithmetic) ')'
    | '+ str(' (VARNAME | NUM | arithmetic) ')'
    | '+str(' (VARNAME | NUM | arithmetic) ')+'
    | '+str(' (VARNAME | NUM | arithmetic) ') +'
    | '+ str(' (VARNAME | NUM | arithmetic) ') +'
    | '+ str(' (VARNAME | NUM | arithmetic) ')+'
    ;
castint
    : 'int(' (VARNAME | string) ')'
    | 'int(' VARNAME '/2)'
    ;

// "string", "SQ", "DQ" adapted from https://www.willowtreeapps.com/craft/an-introduction-to-language-lexing-and-parsing-with-antlr
string
    : SQ
    | DQ
    ;
SQ
    : '\'' ~[^']* '\''
    ; //curiously, this breaks without ~
DQ
    : '"' ~[^"]* '"'
    ;

IFELSE
    : 'if'
    | 'elif'
    | 'else'
    ;

//so CON should obviously have several types (i.e. ">" and "<") that only respond to numbers. however, I ran some strings with those in the IDLE IDE and it... I think it compares string length? I'm not sure, but it's valid.
CON
    : '=='
    | '<='
    | '>='
    | '<'
    | '>'
    | '!='
    ;
ASOP
    : '='
    | '+='
    | '-='
    | '*='
    | '/='
    | '^='
    | '%='
    ;
SIGNS
    : '+'
    | '-'
    | '/'
    | '*'
    | '%'
    | '^'
    ;

VARNAME
    : [_a-zA-Z][_a-zA-Z0-9]* 
    ;
NUM
    : [-]?[0-9]+
    ;

COM
    : '#' ~[^\n\r]*
    ;

//borrowed WS from the "arithmetic.g4" sample from class
WS
    : [ \r\n\t]+ -> channel (HIDDEN)
    ; 

//Referenced https://tomassetti.me/antlr-mega-tutorial/ "Catchall Rule"
ANY : . ;