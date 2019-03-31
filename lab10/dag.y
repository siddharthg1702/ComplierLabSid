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

int arr[] = {2,3,4,5,6};
int n = 5;

void genArrayCode()
{
	int count = counter[counter.size()-1];
	int prodSoFar = 1;
	for(int i=0;i<count;i++)
	{
		string ind = indices[indices.size()-1];
		indices.pop_back();
		if(i==0)
		{
			prodSoFar *= 4;
			cout<<"t"<<k<<" = "<<ind<<" * "<<prodSoFar<<endl;
			prevIndex.push_back(k);
		}
		else
		{
			prodSoFar*=arr[count-i];
			cout<<"t"<<k<<" = "<<ind<<" * "<<prodSoFar<<endl;
			cout<<"t"<<k+1<<" = t"<<k<<" + t"<<prevIndex[prevIndex.size()-1]<<endl;
			k++;
			prevIndex.pop_back();
			prevIndex.push_back(k);
		}
		k++;
	}
	char temp[100] = "t";
	char temp2[100];
	sprintf(temp2,"%d",prevIndex[prevIndex.size()-1]);
	prevIndex.pop_back();
	strcat(temp,temp2);
	string s(temp);
	indices.push_back(s);
	counter.pop_back();
}


%}

%union{
    char* str;
}

%token <str> ID ADD SUB MUL DIV ASSIGN LP RP MOD OS CS IF WHILE LEQ LT GEQ GT ELSE EQ NEQ SEMI AND OR OB CB NOT DO
%type <str> E array whileStmt ifStmt assign Stmt relOp cond elseStmt doWhileStmt
%start S
%%
S : whileStmt | ifStmt | block | doWhileStmt
  ;

whileStmt : WHILE {
					v.push_back(l_no+2); 
					v.push_back(l_no);
					v.push_back(l_no+1);
					v.push_back(l_no+2);
					v.push_back(l_no+1); 
					printf("L%d : ", l_no++);
					l_no+=3;
				 } 
			LP cond RP 	{ 
							printf("goto L%d \n", v[v.size()-1]); 
							v.pop_back();
							printf("goto L%d \n", v[v.size()-1]);
							v.pop_back();
						}
			block {
				printf("goto L%d\n", v[v.size()-1]);
				v.pop_back();
				printf("\nL%d : \n", v[v.size()-1]);
				v.pop_back();
			}
		  	;

doWhileStmt : DO { v.push_back(l_no+1); v.push_back(l_no+1); v.push_back(l_no); v.push_back(l_no); l_no += 2; } block WHILE LP cond RP { 
							printf("goto L%d \n", v[v.size()-1]); 
							v.pop_back();
							printf("goto L%d \n", v[v.size()-1]);
							v.pop_back();
							printf("\nL%d : \n", v[v.size()-1]);
							v.pop_back();
						} SEMI

block : OB {
				printf("\nL%d : \n", v[v.size()-1]);
				v.pop_back();
			}
		Stmt CB
      | assign | ifStmt | whileStmt | doWhileStmt
      ;

Stmt : assign Stmt| ifStmt Stmt | whileStmt Stmt |doWhileStmt Stmt
     |
     ;

ifStmt : IF {
				v.push_back(l_no+2); 
				v.push_back(l_no+1);
				v.push_back(l_no);
				v.push_back(l_no+1);
				v.push_back(l_no);
				l_no+=3;
			}
			LP cond RP 	{ 
							printf("goto L%d \n", v[v.size()-1]); 
							v.pop_back();
							printf("goto L%d \n", v[v.size()-1]);
							v.pop_back();
						}
			block elseStmt
       ;

elseStmt : ELSE {printf("\ngoto L%d\n",  v[v.size()-2]);} block	{
				printf("\nL%d : \n",  v[v.size()-1]);
				v.pop_back();
			}
		 | {printf("\nL%d :\n",v[v.size()-1]); v.pop_back(); v.pop_back();}
		 ;
	 
cond : 	cond AND {printf("goto L%d \n", l_no); printf("goto L%d \n", v[v.size()-2]); printf("\nL%d : \n", l_no++);} cond
	 |	cond OR  {printf("goto L%d \n", v[v.size()-1]); printf("goto L%d \n", l_no); printf("\nL%d : \n", l_no++);} cond
	 |	ID relOp ID		{
		 					printf("if %s %s %s ", $1, $2, $3); 	
	 					}


relOp : LT 
      | LEQ  
      | GT   
      | GEQ  
      | EQ    
      | NEQ   
      ;


assign : ID ASSIGN E SEMI{ printf("\n%s = %s \n", $1, $3); }
	   | array ASSIGN E SEMI { 
	  			genArrayCode();
				cout<<address[address.size()-1]<<"["<<indices[indices.size()-1]<<"]"<<"="<<$3<<endl;
				address.pop_back();
				indices.pop_back();
			}
	   ;

E : E ADD E {char temp[100]; gencode($1,'+',$3,temp); strcpy($$,temp);}
  | E SUB E {char temp[100]; gencode($1,'-',$3,temp); strcpy($$,temp);}
  | E MUL E {char temp[100]; gencode($1,'*',$3,temp); strcpy($$,temp);}
  | E DIV E {char temp[100]; gencode($1,'/',$3,temp); strcpy($$,temp);}
  | E MOD E {char temp[100]; gencode($1,'%',$3,temp); strcpy($$,temp);}
  | SUB E {char temp[100]; gencodeUnary('-',$2,temp); strcpy($$,temp);}
  | LP E RP {$$=$2;}
  | ID {$$=$1;}
  | array	{ 
	  			genArrayCode();
				cout<<"t"<<k<<" = "<<address[address.size()-1]<<"["<<indices[indices.size()-1]<<"]"<<endl;
				address.pop_back();
				indices.pop_back();
  				char temp[100] = "t"; char temp2[100]; sprintf(temp2,"%d",k); 
				strcat(temp,temp2); 
				k++; 
  				strcpy($$,temp); 
			}
  ;


array : array OS E CS	{ counter[counter.size()-1]++; string s($3); indices.push_back(s); } 	
	  | ID { counter.push_back(0);  string s($1); address.push_back(s); } OS E CS	{ counter[counter.size()-1]++;  string s($4); indices.push_back(s); }			
	  ;
%%

int main(int argc, char** argv)
{
	yyparse();
	return 0;
}
