%{
#include<bits/stdc++.h>
using namespace std;

extern "C" {
	void yyerror(const char* str)
	{
		printf("Error\n");
	}
	int yylex(void);
	int yywrap(void) 
	{
		return 1;
	}
}

int k=0, l_no=0;
int t,f;
vector<int>v, counter;
vector<int>prevIndex;
vector<string>address, indices;

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

%token <str> ID ADD SUB MUL DIV ASSIGN LP RP MOD OS CS LEQ LT GEQ GT ELSE EQ NEQ SEMI AND OR OB CB NOT FOR COMMA
%type <str> E T F forStmt assign Stmt relOp cond updation postFix
%start S
%%
S : forStmt
  ;


block : OB {
			printf("\nL%d : \n", v[v.size()-1]);
			v.pop_back();
		}
	Stmt CB
      ;

Stmt : assign Stmt| forStmt Stmt
     |
     ;

forStmt : FOR {
		v.push_back(l_no);
		v.push_back(l_no+1);
		v.push_back(l_no+3);
		v.push_back(l_no+2);
		
		l_no = l_no + 3;
	}
	LP assign {
		printf("\nL%d:\n", v[v.size()-4]);
	}
	cond {
		printf("goto L%d\n goto L%d\n", v[v.size()-1], v[v.size()-2]);
	}
	SEMI {
		printf("\nL%d:\n", v[v.size()-3]);
	}
	updation {
		printf("goto L%d\n ", v[v.size()-4]);
	}
	RP block {
		printf("goto L%d\n", v[v.size()-2]);
		printf("\nL%d:\n\n", v[v.size()-1]);
	}

assign : ID ASSIGN E COMMA assign{ printf("%s = %s \n", $1, $3); }
	 | ID ASSIGN E SEMI{ printf("%s = %s \n", $1, $3); }
	 | postFix COMMA assign
	 | postFix SEMI
	   ;

updation : ID ASSIGN E COMMA updation{ printf("%s = %s \n", $1, $3); }
	 | ID ASSIGN E{ printf("%s = %s \n", $1, $3); }
	 | postFix COMMA updation
	 | postFix
	   ;

postFix : ID ADD ADD {printf("%s = %s + 1 \n", $1, $1);}

E : E ADD T {char temp[100]; gencode($1,'+',$3,temp); strcpy($$,temp);}
  | E SUB T {char temp[100]; gencode($1,'-',$3,temp); strcpy($$,temp);}
  | T {$$=$1;}
  ;
  
T : T MUL F {char temp[100]; gencode($1,'*',$3,temp); strcpy($$,temp);}
  | T DIV F {char temp[100]; gencode($1,'/',$3,temp); strcpy($$,temp);}
  | F {$$=$1;}
  ;
  
F : ID {$$=$1;};


  
cond : 	cond AND {printf("goto L%d \n", l_no); printf("goto L%d \n", v[v.size()-2]); printf("\nL%d : \n", l_no++);} cond
	 |	cond OR  {printf("goto L%d \n", v[v.size()-1]); printf("goto L%d \n", l_no); printf("\nL%d : \n", l_no++);} cond
	 |	E relOp E		{
		 					printf("if %s %s %s ", $1, $2, $3); 	
	 					}


relOp : LT 
      | LEQ  
      | GT   
      | GEQ  
      | EQ    
      | NEQ   
      ;
%%

int main(int argc, char** argv)
{
	yyparse();
	return 0;
}
