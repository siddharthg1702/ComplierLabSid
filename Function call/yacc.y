%{
    #include<bits/stdc++.h>
    using namespace std;

    extern "C"{
        void yyerror(char* str){
            printf("Error\n");
        }
        int yylex(void);
        int yywrap(void){
            return 1;
       }
    }
    int k = 0;
    int p = 0;
%}

%union{
    char* str;
}

%token <str> LP RP SEMI OB CB COMMA ID VAL INT FLOAT CHAR VOID ASSIGN
%type<str> S param
%start S

%%

S : ID ASSIGN ID LP param RP {printf("\nt%d =  call %s , %d",k,$3,p);printf("\n%s = t%d",$1,k);k++;} SEMI {printf("\nAccepted");}
  ;
  
param : ID      {p++; printf("\nparam %s\n",$1);}          
      | ID {p++; printf("\nparam %s",$1);} COMMA param 
      ;

%%

int main(int argc,char** argv){
    yyparse();
    return 0;
}
