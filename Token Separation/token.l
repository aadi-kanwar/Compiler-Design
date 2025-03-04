%{
%}
%%
[0-9]+[.][0-9]+ printf("%s is a floating number\n",yytext);
int|float|char|double|void printf("%s is a datatype\n",yytext);
[0-9]+ printf("%s is an integer number\n",yytext);
[a-z]+[()] printf("%s is a function\n",yytext);
[a-z]+ printf("%s is an identifier\n",yytext);
[+=*/-] printf("%s is an operator\n",yytext);
, printf("%s is a spearator\n",yytext);
; printf("%s is a delimeter\n",yytext);

[#][a-z\.h]+ printf("%s is a preprocessor\n",yytext);
%%

int yywrap(void)
{
	return 1;
}

int main()
{
	//reads input from a file named test.c rather than terminal
	freopen("test.c","r",stdin);
		yylex();
		return 0;
}
