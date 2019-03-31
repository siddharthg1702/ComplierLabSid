WS  [ \t\v\n\f]
%%

[a-zA-Z0-9_]+ { if(strcmp(yytext,"int") == 0) fprintf(yyout,"float");  else fprintf(yyout,"%s", yytext);}

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
