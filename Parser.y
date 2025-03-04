%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);  // Declaring lexer function
void yyerror(const char *s);  // Error handling function

// Symbol table for variable storage (for simplicity, just a basic one)
typedef struct {
    char name[32];
    int value;
    int is_float;
} Symbol;

Symbol symbol_table[100];
int symbol_count = 0;

int lookup_symbol(char *name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return i;
        }
    }
    return -1;
}

void add_symbol(char *name, int value, int is_float) {
    Symbol s;
    strcpy(s.name, name);
    s.value = value;
    s.is_float = is_float;
    symbol_table[symbol_count++] = s;
}

void set_symbol_value(char *name, int value) {
    int index = lookup_symbol(name);
    if (index != -1) {
        symbol_table[index].value = value;
    } else {
        printf("Error: Variable %s not declared.\n", name);
    }
}

int get_symbol_value(char *name) {
    int index = lookup_symbol(name);
    if (index != -1) {
        return symbol_table[index].value;
    } else {
        printf("Error: Variable %s not declared.\n", name);
        return -1;
    }
}

%}

/* Tokens from lexer */
%token IF ELSE WHILE INT FLOAT ID NUM FLOATNUM
%token PLUS MINUS MUL DIV ASSIGN EQ LT GT NEQ
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA RETURN

%%

/* Grammar Rules */

/* Start symbol */
program:
    declaration_list statement_list
;

declaration_list:
    declaration
    | declaration_list declaration
;

declaration:
    INT ID SEMICOLON {
        add_symbol($2, 0, 0);  // Declare an integer variable
    }
    | FLOAT ID SEMICOLON {
        add_symbol($2, 0, 1);  // Declare a float variable
    }
;

statement_list:
    statement
    | statement_list statement
;

statement:
    expr SEMICOLON
    | ID ASSIGN expr SEMICOLON {
        set_symbol_value($1, $3);
    }
    | IF LPAREN expr RPAREN statement {
        if ($3) { $$ = 1; } else { $$ = 0; }
    }
    | IF LPAREN expr RPAREN statement ELSE statement {
        if ($3) {
            $$ = 1;
        } else {
            $$ = 0;
        }
    }
    | WHILE LPAREN expr RPAREN statement {
        while ($3) { $$ = 1; }
    }
    | RETURN expr SEMICOLON {
        $$ = $2; // Return an expression result
    }
    | LBRACE statement_list RBRACE
;

expr:
    ID {
        $$ = get_symbol_value($1);  // Retrieve the value of a variable
    }
    | NUM {
        $$ = atoi($1);  // Convert string to integer
    }
    | FLOATNUM {
        $$ = atof($1);  // Convert string to float
    }
    | expr PLUS expr {
        $$ = $1 + $3;
    }
    | expr MINUS expr {
        $$ = $1 - $3;
    }
    | expr MUL expr {
        $$ = $1 * $3;
    }
    | expr DIV expr {
        if ($3 == 0) {
            yyerror("Division by zero!");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | LPAREN expr RPAREN {
        $$ = $2;  // Parentheses grouping
    }
;

%%

/* Error handling function */
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

/* Main function for parsing */
int main() {
    yyparse();  // Start parsing process
    return 0;
}
