%{
#include<stdio.h>
int state = 1;
%}

%%
a {
	if (state == 1)
		state = 2;
	else if (state == 2)
		state = 2;
	else if (state == 3){
		printf("State 3");
		state = 2;
	}
}

b {
	if (state == 1)
		state = 1;
	else if (state == 2)
		state = 3;
	else if (state == 3){
		printf("State 3");
		state = 1;
	}
}

[\t\n] {/* Ignore whitespace*/}

. {
	printf("Invalid Character\n");
	state = 1;
}

%% 
int yywrap(void)
	{
		return 1;
	}

int main()
{
	printf("Enter a string:");
	yylex();
	if(state == 2)
		printf("The string ends in ab\n");
	else
		printf("The string does not end in ab\n");
	return 0;
}

