%{
    #include<stdio.h>
    #include"y.tab.h"
%}

%%

"("		yylval.str=strdup(yytext);return LP;
")"		yylval.str=strdup(yytext);return RP;
"+"		yylval.str=strdup(yytext);return ADD;
"-"		yylval.str=strdup(yytext);return SUB;
"*"		yylval.str=strdup(yytext);return MUL;
"/"		yylval.str=strdup(yytext);return DIV;
"="		yylval.str=strdup(yytext);return ASSIGN;
"%"		yylval.str=strdup(yytext);return MOD;
"["		yylval.str=strdup(yytext);return OS;
"]"		yylval.str=strdup(yytext);return CS;
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

