// first parser rules then LEXER ONES
// lexer rules analyzed in order they appear; can be ambiguous


grammar Test;

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
    : 'for' VARNAME 'in' 'range(' (NUM | VARNAME) ',' (NUM | VARNAME) ')' ':' //for each specifically
    ;

variable
    : VARNAME ASOP (VARNAME | NUM | (string)* | arithmetic)
    ;

arithmetic
    : (VARNAME | NUM) (SIGNS (VARNAME | NUM))+
    ;

conditional
    : (VARNAME | NUM | string) WS* CON WS* (VARNAME | NUM | string)
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
    

VARNAME
    : [_a-zA-Z][_a-zA-Z0-9]* 
    ;

NUM
    : [-]?[0-9]+
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

//...what is '^'??
SIGNS
    : '+'
    | '-'
    | '/'
    | '*'
    | '%'
    | '^'
    | '**'
    ;

COM
    : '#' ~[^\n\r]*
    ;

//borrowed WS from the "arithmetic.g4" sample from class
WS
    : [ \r\n\t]+ -> channel (HIDDEN)
    ; 