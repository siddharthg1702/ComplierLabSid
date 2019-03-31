%{
	#include<bits/stdc++.h>
	using namespace std;
	extern char* yytext;
	extern "C"{     //C linking for c++ compiler
		int yylex(void);
		void yyerror(const char* st){
			printf("error: %s\n",yytext);
		}
		int yywrap(){	return 1;	}
	}
	vector< vector<string> > s(100000);
	void print();
	void remove();
	int i = 0;
%}

%token ID TYPE KEY OB CB COMMA SEMI

%%

S
	: OB {i++;} Decl CB {print(); remove();} S
	|
	;

Decl
	: TYPE{s[i].push_back(yytext);} ID {s[i].push_back(yytext);} Further
	| S                                      //Statement can be a block itself
	| SEMI									// Just a semicolon is a valid statement	
	;

Further
	: COMMA ID {s[i].push_back(yytext);} Further		// for comma separated declarations like a,b,c
	| SEMI Decl											// for terminating such a declaration and proceeding further
	;
	
%%
void print()
{
	for(int x=1; x<=i; x++)
	{
		for(int j=0; j<s[x].size(); j++)
		{
			cout<<s[x][j]<<" ";
		}
		cout<<endl;
	}
	
	cout<<"---------END OF BLOCK-------------"<<endl;	
}

void remove()
{
	s[i].resize(0);
	i--;
}

int main(){	
	cout<<"\n";
	yyparse();
}
