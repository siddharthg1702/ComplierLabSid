WS  [ \t\v\n\f]

%%

{WS}+ { fprintf(yyout," "); } 
%%

#include<stdio.h>

int yywrap() {
	return 1;
}

int main(int argc,char** argv)
{
	if(argc>1)
	{
		FILE *ifp, *ofp;
		ifp = fopen(argv[1],"r");
		ofp = fopen(argv[2],"w");
		yyin = ifp;
		yyout = ofp;
	}
	yylex();
} 
