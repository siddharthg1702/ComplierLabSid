%{
    #include<stdio.h>
    #include"yacc.hh"
%}

%%

"GRAPH"					yylval.str=strdup(yytext);return GRAPH;
","					yylval.str=strdup(yytext);return COMMA;


"("					yylval.str=strdup(yytext);return LP;
")"					yylval.str=strdup(yytext);return RP;

"+"					yylval.str=strdup(yytext);return ADD;
"-"					yylval.str=strdup(yytext);return SUB;
"?"					yylval.str=strdup(yytext);return DISP;

[a-zA-Z_][a-zA-Z0-9_]* 			yylval.str=strdup(yytext);return ID;
[0-9]+ 					yylval.str=strdup(yytext);return NUM;

[\n \t] ;

%%
