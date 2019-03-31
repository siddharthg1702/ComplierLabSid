%{
    #include<stdio.h>
    #include"y.tab.h"
%}

%%

"("		yylval.str=strdup(yytext);return LP;
")"		yylval.str=strdup(yytext);return RP;
"&&"		yylval.str=strdup(yytext);return AND;
"||"		yylval.str=strdup(yytext);return OR;
"!"		yylval.str=strdup(yytext);return NOT;
">>"		yylval.str=strdup(yytext);return LS;
"<<"		yylval.str=strdup(yytext);return RS;
"~"		yylval.str=strdup(yytext);return TIL;
"^"		yylval.str=strdup(yytext);return XOR;
"="		yylval.str=strdup(yytext);return ASSIGN;

[a-zA-Z_][a-zA-Z0-9_]* 	yylval.str=strdup(yytext);return ID;
[0-9]+ yylval.str=strdup(yytext);return ID;

[\n \t] ;
%%

void yyerror(char* str)
{
        printf("\n%s",str);
}


int yywrap()
{
    return 1;
}

int main(int argc, char** argv)
{
	FILE *file;
    file = fopen(argv[1], "r");
    yyset_in(file);
    yyparse();
}

