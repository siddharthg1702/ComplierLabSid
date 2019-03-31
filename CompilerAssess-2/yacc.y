%{
	#include<bits/stdc++.h>
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>

	using namespace std;
	extern char* yytext;
	extern "C"{     //C linking for c++ compiler
		int yylex(void);
		void yyerror(const char* st){
			printf("error: %s\n",yytext);
		}
		int yywrap(){	return 1;	}
	}

	int k=0;
	int l_no = 0;
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
	vector<int> v;
%}

%union{
    char* str;
}

%token <str> ID ADD SUB MUL DIV ASSIGN LP RP MOD IF ELSE OB CB WHILE AND OR NOT LT LEQ GT GEQ EQ NEQ SEMI OS CS DO
%type <str> E Cond relOp Ind
%left '+' '-'
%left '*' '/' '%'
%right '='
%start S

%%

S : WhileStmt | IfStmt | DoWhile | Block
  ;

DoWhile : DO 	{
			v.push_back(l_no + 1);
			v.push_back(l_no);
			
			l_no = l_no + 2;
		}
		Block {
			
		}
		WHILE LP Cond RP {
			printf("goto L%d \n", v[v.size()-1]); 
			printf("goto L%d \n", v[v.size()-2]);
			v.pop_back();
			
			printf("\nL%d : \n", v[v.size()-1]);
			v.pop_back();
		}

WhileStmt : WHILE {
				v.push_back(l_no+2); 
				v.push_back(l_no);
				v.push_back(l_no+1); 
				printf("L%d : ", l_no++);
			 }
			LP Cond RP {
				printf("goto L%d \n", l_no++); 
				printf("goto L%d \n", l_no++);
			}
			Block {
				printf("goto L%d\n", v[v.size()-1]);
				v.pop_back();
				printf("\nL%d : \n", v[v.size()-1]);
				v.pop_back();
			}
		  	;

Block : OB {
			printf("\nL%d : \n", v[v.size()-1]);
			v.pop_back();
		}
		Stmt CB
      | AssigStmt | IfStmt | WhileStmt
      ;

Stmt : AssigStmt Stmt| IfStmt Stmt | WhileStmt Stmt
     |
     ;

IfStmt : IF {
				v.push_back(l_no+2); 
				v.push_back(l_no+1);
				v.push_back(l_no);	
			}
			LP Cond RP {
				printf("goto L%d \n", l_no++);
				printf("goto L%d \n", l_no++);
			}
			Block	{
				printf("goto L%d\n", v[v.size()-2]);
			}
			ELSE Block	{
				printf("goto L%d\n", v[v.size()-1]);
				printf("\nL%d : \n",  v[v.size()-1]);
				v.pop_back();
			}
	   | IF {
				v.push_back(l_no+2); 
				v.push_back(l_no+1);
				v.push_back(l_no);
			}
			LP Cond RP Block		{
				printf("\nL%d : \n",  v[v.size()-1]);
				v.pop_back();
			}
       ;

AssigStmt : ID ASSIGN E SEMI{ printf("%s = %s \n", $1, $3); } AssigStmt
     |
     ;

E : E ADD E  {char temp[100]; gencode($1,'+',$3,temp); strcpy($$,temp);}
  | E SUB E {char temp[100]; gencode($1,'-',$3,temp); strcpy($$,temp);}
  | E MUL E {char temp[100]; gencode($1,'*',$3,temp); strcpy($$,temp);}
  | E DIV E {char temp[100]; gencode($1,'/',$3,temp); strcpy($$,temp);}
  | E MOD E {char temp[100]; gencode($1,'%',$3,temp); strcpy($$,temp);}
  | SUB E {char temp[100]; gencodeUnary('-',$2,temp); strcpy($$,temp);}
  | LP E RP {$$=$2;}
  | ID OS Ind CS OS Ind CS {
  	 	printf("t%d = %s * 12\n", k++, $3);
  	 	printf("t%d = %s * 4\n", k++, $6);
  	 	printf("t%d = t%d + t%d\n", k, k-1, k-2);
  	 	k++;
  	 	char temp[100];
  	 	printf("t%d = %s [ t%d ] \n", k, $1, k-1);
  	 	k++;
  	 	sprintf(temp, "t%d", k-1);
  	 	strcpy($$, temp);
  	}
  | ID OS Ind CS	{
  	 	printf("t%d = %s * 4\n", k++, $3);
  	 	char temp[100];
  	 	printf("t%d = %s [ t%d ] \n", k, $1, k-1);
  	 	k++;
  	 	sprintf(temp, "t%d", k-1);
  	 	strcpy($$, temp);
  	}
  | ID {$$=$1;}
  ;

Ind : E{$$=$1;};

Cond : ID relOp ID		{printf("if %s %s %s ", $1, $2, $3); }

relOp : LT
      | LEQ
      | GT
      | GEQ
      | EQ
      | NEQ
      ;
%%

int main()
{
    yyparse();
}
