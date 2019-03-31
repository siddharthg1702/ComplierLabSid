%{
	#include "symbol.hh"
	#include<stdio.h>
%}

%%

(const|unsigned|signed|short)?" "*(int|float|char|double|string|auto|long|void)	return TYPE;

struct|break|continue|if|else|while|switch|default|do|for|sizeof|goto|static 	return KEY;

"{"	return OB;
"}"	return CB;

","	return COMMA;
";" return SEMI;

[a-zA-Z_][a-zA-Z_0-9]*	return ID;

[\n \t]* ;
. ;

%%
