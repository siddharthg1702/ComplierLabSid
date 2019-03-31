%{
    #include<stdio.h>
    #include"y.tab.h"
    char k='a';
    int cycle = 0;
%}

%%
[0-9]+ {
yylval.dval=yytext[0];
return NUM;
}

\n {return 0;}
. {return yytext[0];}
%%

void yyerror(char* str)
{
        printf("\n%s",str);
}
int charToInt(char ch, int cycle)
{
	int res = 0;
	int i;
	for(i=0; i<cycle; i++)
	{
		res+=26;
	}
	res+=ch-'a';
	
	return res;
}
char gencode(char first,char op,char second, int *cy)
{
    char temp[10];
    printf("t%d = ", k-'a');
    if(first >= '0' && first <= '9')
    	printf("%c ", first);
    else
    	printf("t%d ", charToInt(first, cycle));
    
    printf("%c ", op);
    
    if(second >= '0' && second <= '9')
    	printf("%c ", second);
    else
    	printf("t%d ", charToInt(second, cycle));
    k++;
    if(k > 'z')
    {
    	k = 'a';
    	cycle++;
    	*cy = cycle;
    }
    
    printf("\n");
    
    if(k == 'a')
	    return 'z';
	else
		return (k-1);
}
int yywrap()
{
    return 1;
}

main()
{
        yyparse();
        return 0;
}
