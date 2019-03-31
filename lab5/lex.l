%{
	#include<stdio.h>
	#include "y.tab.h"
%}

text [a-zA-Z0-9+\-=/*<>!&|,]
%%

"for"				yylval.str=strdup(yytext); return(FOR);
"("					yylval.str=strdup(yytext); return(LP);
")"					yylval.str=strdup(yytext); return(RP);
";"					yylval.str=strdup(yytext); return(SEMI);
"{"					yylval.str=strdup(yytext); return(OB);
"}"					yylval.str=strdup(yytext); return(CB);
({text}" "?)*				yylval.str=strdup(yytext); return(TEXT);

%%

int yywrap(void)
{
	return 1;
}
