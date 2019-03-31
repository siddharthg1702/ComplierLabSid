%{
    #include<stdio.h>
    #include"yacc.hh"
%}

%%

"if"					yylval.str=strdup(yytext);return IF;
"else"					yylval.str=strdup(yytext);return ELSE;
"while"					yylval.str=strdup(yytext);return WHILE;
"do"					yylval.str=strdup(yytext);return DO;
"&&"					yylval.str=strdup(yytext);return AND;
"||"					yylval.str=strdup(yytext);return OR;
"!"					yylval.str=strdup(yytext);return NOT;
";"					yylval.str=strdup(yytext);return SEMI;

"<"					yylval.str=strdup(yytext);return LT;
"<="					yylval.str=strdup(yytext);return LEQ;
">"					yylval.str=strdup(yytext);return GT;
">="					yylval.str=strdup(yytext);return GEQ;
"!=" 					yylval.str=strdup(yytext);return NEQ;
"=="					yylval.str=strdup(yytext);return EQ;

"["					yylval.str=strdup(yytext);return OS;
"]"					yylval.str=strdup(yytext);return CS;

"("					yylval.str=strdup(yytext);return LP;
")"					yylval.str=strdup(yytext);return RP;
"{"					yylval.str=strdup(yytext);return OB;
"}"					yylval.str=strdup(yytext);return CB;
"+"					yylval.str=strdup(yytext);return ADD;
"-"					yylval.str=strdup(yytext);return SUB;
"*"					yylval.str=strdup(yytext);return MUL;
"/"					yylval.str=strdup(yytext);return DIV;
"="					yylval.str=strdup(yytext);return ASSIGN;
"%"					yylval.str=strdup(yytext);return MOD;
[a-zA-Z_][a-zA-Z0-9_]* 			yylval.str=strdup(yytext);return ID;
[0-9]+ 					yylval.str=strdup(yytext);return ID;

[\n \t] ;
%%


