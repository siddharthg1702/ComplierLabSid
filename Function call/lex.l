%{
    #include<stdio.h>
    #include"lex.hh"
%}

%%

"int"       yylval.str = strdup(yytext); return INT;
"float"       yylval.str = strdup(yytext); return FLOAT;
"char"       yylval.str = strdup(yytext); return CHAR;
"void"       yylval.str = strdup(yytext); return VOID;

"("       yylval.str = strdup(yytext); return LP;
")"       yylval.str = strdup(yytext); return RP;
"{"       yylval.str = strdup(yytext); return OB;
"}"       yylval.str = strdup(yytext); return CB;
","       yylval.str = strdup(yytext); return COMMA;
";"       yylval.str = strdup(yytext); return SEMI;
"="       yylval.str = strdup(yytext); return ASSIGN;
[a-zA-Z_][a-zA-Z_0-9]*  yylval.str = strdup(yytext); return ID;
([0-9]*\.?[0-9]*)|(\".*?\")|(\'.\')	yylval.str=strdup(yytext);return VAL;  
[\n\t]    ;
"."       ;

%%
