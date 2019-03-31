%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int k=0;
void gencode(char* first,char op,char* second, char* rtn)
{
    char temp[100];
    char start[100] = "t";
    printf("t%d = %s %c %s", k, first, op, second);
    int t = k;
    k++;
    printf("\n");
    sprintf(temp,"%d",t);
    strcat(start,temp);
    strcpy(rtn, start);
}

void gencodeUnary(char op,char* second, char* rtn)
{
    char temp[100];
    char start[100] = "t";
    printf("t%d = %c %s", k, op, second);
    int t = k;
    k++;
    printf("\n");
    sprintf(temp,"%d",t);
    strcat(start,temp);
    strcpy(rtn, start);
}
%}

%union{
    char* str;
}

%token <str> ID ADD SUB MUL DIV ASSIGN LP RP MOD OS CS
%type <str> E
%left '+' '-'
%left '*' '/' '%'
%right '='
%start S

%%
S : ID ASSIGN E { printf("\n%s = %s \n", $1, $3); }

E : E ADD E {char temp[100]; gencode($1,'+',$3,temp); strcpy($$,temp);}
  | E SUB E {char temp[100]; gencode($1,'-',$3,temp); strcpy($$,temp);}
  | E MUL E {char temp[100]; gencode($1,'*',$3,temp); strcpy($$,temp);}
  | E DIV E {char temp[100]; gencode($1,'/',$3,temp); strcpy($$,temp);}
  | E MOD E {char temp[100]; gencode($1,'%',$3,temp); strcpy($$,temp);}
  | SUB E {char temp[100]; gencodeUnary('-',$2,temp); strcpy($$,temp);}
  | LP E RP {$$=$2;}
  | ID OS ID CS OS ID CS {
  	 	printf("t%d = %s*12\n", k++, $3);
  	 	printf("t%d = %s*4\n", k++, $6);
  	 	printf("t%d = t%d + t%d\n", k, k-1, k-2);
  	 	k++;
  	 	char temp[100];
  	 	printf("t%d = %s [ t%d ] \n", k, $1, k-1);
  	 	k++;
  	 	sprintf(temp, "t%d", k-1);
  	 	strcpy($$, temp);
  	}
  | ID OS ID CS	{
  	 	printf("t%d = %s*4\n", k++, $3);
  	 	char temp[100];
  	 	printf("t%d = %s [ t%d ] \n", k, $1, k-1);
  	 	k++;
  	 	sprintf(temp, "t%d", k-1);
  	 	strcpy($$, temp);
  	}
  | ID {$$=$1;}
  ;

%%
