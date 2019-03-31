%{
#include<stdio.h>
int aaa;
int cy = 0;
%}

%union{
    char dval;
}

%token <dval> NUM
%type <dval> E
%left '+' '-'
%left '*' '/' '%'

%%
statement : E {printf("\nt = t%d \n", charToInt($1, cy));
}
          ;

E : E '+' E 
    {   
		char test=gencode($1,'+',$3, &cy);
        $$=test;
    }
  | E '-' E 
    {
        char test=gencode($1,'-',$3, &cy);
        $$=test;
    }
  | E '%' E 
    {
        char test=gencode($1,'%',$3, &cy);
        $$=test;
    }
  | E '*' E 
    {
		char test=gencode($1,'*',$3, &cy);
        $$=test;
    }
  | E '/' E 
    {
        char test=gencode($1,'/',$3, &cy);
        $$=test;
    }
  | '(' E ')' 
    {
        $$=$2;
    }
  | NUM 
    {
        $$=$1;
    }
  ;
%%
