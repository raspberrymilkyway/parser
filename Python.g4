// Kylee Willis (kwcnr)
grammar Python;



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

//var[iable]handle[-ing]
varhandle
    : VARNAME ASOP (VARNAME | NUM | arithmetic | string | cast)
    ;

arithmetic
    : (VARNAME | NUM | castint) (SIGNS (VARNAME | NUM | castint))+
    ;

conditional
    : (VARNAME | NUM | string | arithmetic) CON (VARNAME | NUM | string | arithmetic)
    ;

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
//S[ingle]Q[uotes]
SQ
    : '\'' ~[^']* '\''
    ; //curiously, this breaks without ~
//D[ouble]Q[uotes]
DQ
    : '"' ~[^"]* '"'
    ;

//were I building code to use this, I'd probably separate these a bit vvv
IFELSE
    : 'if'
    | 'elif'
    | 'else'
    ;

//CON[ditionals] with a string > string are valid in Python
CON
    : '=='
    | '<='
    | '>='
    | '<'
    | '>'
    | '!='
    ;
//AS[signment]OP[erator]
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

//COM[ment]
COM
    : '#' ~[^\n\r]*
    ;

INDENT
    : '    '
    | '\t'
    ;

//borrowed WS from the "arithmetic.g4" sample from class
WS
    : [ \r\n\t]+ -> channel (HIDDEN)
    ; 

//Referenced https://tomassetti.me/antlr-mega-tutorial/ "Catchall Rule"
ANY : . ;