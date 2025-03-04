%{
    #include "y.tab.h"
%}

%%

"int"           { return INT; }
"float"         { return FLOAT; }
"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"return"        { return RETURN; }

"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }
"="             { return ASSIGN; }

"=="            { return EQ; }
"<"             { return LT; }
">"             { return GT; }
"!="            { return NEQ; }

"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
";"             { return SEMICOLON; }
","             { return COMMA; }

[0-9]+          { yylval = atoi(yytext); return NUM; }
[0-9]+"."[0-9]+ { yylval = atof(yytext); return FLOATNUM; }

[a-zA-Z_][a-zA-Z0-9_]* { return ID; }

[ \t\n]+        { /* Ignore whitespace */ }
.               { printf("Invalid character: %s\n", yytext); return 0; }

%%

int yywrap() {
    return 1;
}

