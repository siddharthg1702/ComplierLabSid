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
"+="	yylval.str=strdup(yytext);return ADDASSIGN;
"-="	yylval.str=strdup(yytext);return SUBASSIGN;
"*="	yylval.str=strdup(yytext);return MULASSIGN;
"/="	yylval.str=strdup(yytext);return DIVASSIGN;
"%="	yylval.str=strdup(yytext);return MODASSIGN;
"<<="	yylval.str=strdup(yytext);return SLASSIGN;
">>="	yylval.str=strdup(yytext);return SRASSIGN;
"&="	yylval.str=strdup(yytext);return BANDASSIGN;
"|="	yylval.str=strdup(yytext);return BORASSIGN;
"^="	yylval.str=strdup(yytext);return BXORASSIGN;
";"		yylval.str=strdup(yytext);return SEMI;
"%"		yylval.str=strdup(yytext);return MOD;
"<"		yylval.str=strdup(yytext);return LT;
">"		yylval.str=strdup(yytext);return GT;
"<="	yylval.str=strdup(yytext);return LE;
">="	yylval.str=strdup(yytext);return GE;
"=="	yylval.str=strdup(yytext);return EQ;
"!="	yylval.str=strdup(yytext);return NEQ;
"&&"	yylval.str=strdup(yytext);return LAND;
"||"	yylval.str=strdup(yytext);return LOR;
"&"		yylval.str=strdup(yytext);return BAND;
"|"		yylval.str=strdup(yytext);return BOR;
"^"		yylval.str=strdup(yytext);return BXOR;
"<<"	yylval.str=strdup(yytext);return SL;
">>"	yylval.str=strdup(yytext);return SR;
"!"		yylval.str=strdup(yytext);return LNOT;
"~"		yylval.str=strdup(yytext);return BNOT;
"++"	yylval.str=strdup(yytext);return INC;
"--"	yylval.str=strdup(yytext);return DEC;

[a-zA-Z_][a-zA-Z0-9_]* 	yylval.str=strdup(yytext);return ID;
[\n \t] ;

%%

int yywrap(void)
{
	return 1;
}
