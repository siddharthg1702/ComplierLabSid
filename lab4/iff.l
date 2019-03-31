%{
	#include<stdio.h>
	#include "y.tab.h"
	int x=0;
%}
L   [a-zA-Z_]
A   [a-zA-Z_0-9]
D	[0-9]
%%

"(" {return LPAREN;}
")" {return RPAREN;}
";" {return SEMI;}
"{" {return OBRACE;}
"}" {return CBRACE;}

"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"for" {return FOR;}

"<" {return LT;}
"<=" {return LEQ;}
">" {return GT;}
">=" {return GEQ;}
"!=" {return NEQ;}
"==" {return EQ;}
"=" {return ASS;}

"++" {return INC;}
"--" {return DEC;}

{L}{A}* {return ID;}
{D}+ {return VAL;}

%%
int yywrap(void)
{
	return 1;
}
