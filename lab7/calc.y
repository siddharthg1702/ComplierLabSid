%{
	#include<stdio.h>
	#include<stdlib.h>
%}

%token LP RP ADD SUB MUL DIV ASSIGN SEMI MOD ID 
%type<a> assignment exp term fact ID

%union {
	int a;
}

%%

assignment
	: ASSIGN exp	{printf("%d",$2);}

exp
	: exp ADD term	{$$ = $1+$3;}
	| exp SUB term	{$$ = $1-$3;}
	| term			{$$ = $1;}
	;

term
	: term MUL fact		{$$ = $1*$3;}
	| term DIV fact		{$$ = $1/$3;}
	| term MOD fact 	{$$ = $1%$3;}
	| fact				{$$ = $1;}
	;

fact
	: ID			{$$ = $1;}
	| LP exp RP		{$$ = $2;}
	;

%%

int main(int argc, char** argv)
{
	FILE *file;
    file = fopen(argv[1], "r");
    yyparse();
}

int yyerror(char *str) {
	printf("There was an error.");
	return 0;
}
