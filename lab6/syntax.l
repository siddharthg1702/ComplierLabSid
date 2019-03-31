%{
	#include<stdio.h>
	#include "y.tab.h"
%}

%%

"("		yylval.str=strdup(yytext);return LP;
")"		yylval.str=strdup(yytext);return RP;
"+"		yylval.str=strdup(yytext);return ADD;
"-"		yylval.str=strdup(yytext);return SUB;
"*"		yylval.str=strdup(yytext);return MUL;
"/"		yylval.str=strdup(yytext);return DIV;
"="		yylval.str=strdup(yytext);return ASSIGN;
";"		yylval.str=strdup(yytext);return SEMI;
"%"		yylval.str=strdup(yytext);return MOD;

[a-zA-Z_][a-zA-Z0-9_]* 	yylval.str=strdup(yytext);return ID;
[\n \t] ;

%%

int yywrap(void)
{
	return 1;
}
