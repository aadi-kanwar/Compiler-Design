%{
int n=0;
%}
%%
[0-9]+[.][0-9]+ n++;

int|float|char|double|void n++;
[0-9]+ n++;
[a-z]+[()] n++;
[a-z]+ n++;
[+=*/-] n++;
, n++;
; n++;

[#][a-z\.h]+ n++;
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
	printf("\n total no. of token = %d\n", n); 
	return 0;
}
