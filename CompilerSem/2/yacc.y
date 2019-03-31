%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int k=0;
void gencode(char* first,char* op,char* second, char* rtn)
{
    char temp[100];
    char start[100] = "t";
    printf("t%d = %s %s %s", k, first, op, second);
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

%token <str> ID AND OR NOT RS LS TIL XOR LP RP ASSIGN
%type <str> E T F
%left '+' '-'
%left '*' '/' '%'
%right '='
%start S

%%
S : ID ASSIGN E { printf("\n%s = %s \n", $1, $3); }

E : E AND T {char temp[100]; gencode($1,"&&",$3,temp); strcpy($$,temp);}
  | E OR T {char temp[100]; gencode($1,"||",$3,temp); strcpy($$,temp);}
  | T
  ;

T : NOT T {char temp[100]; gencodeUnary('!',$2,temp); strcpy($$,temp);}
  | XOR T {char temp[100]; gencodeUnary('^',$2,temp); strcpy($$,temp);}
  | TIL T {char temp[100]; gencodeUnary('~',$2,temp); strcpy($$,temp);}
  | F
  ;

F : 
  | LP E RP {$$=$2;}
  | ID {$$=$1;}
  ;

%%
