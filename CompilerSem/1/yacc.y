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
	
	int no = 1;
	
	map <string, int> mp;
	map<string, int> size;
	vector<int> v[20];
	
	string curr = "";
}

%}

%union{
    char* str;
}

%token <str> NUM ID DISP ADD SUB LP RP COMMA GRAPH
%type <str> S DeclStmt DeclCont
%start S
%%

S : DeclStmt S | DispGraph S | UpdateGraph S |;

UpdateGraph : ID ADD LP NUM NUM RP {
		int matNo = mp[$1];
	   	int n = size[$1];
	   	
	   	printf("Add %s %s\n", $4, $5);
	   	
	   	int i = atoi($4), j = atoi($5);
	   	i--; j--;
	   	
	   	v[matNo][(i*n)+j] = 1;
	     }
	     | ID SUB LP NUM NUM RP {
		int matNo = mp[$1];
	   	int n = size[$1];
	   	
	   	printf("Sub %s %s\n", $4, $5);
	   	
	   	int i = atoi($4), j = atoi($5);
	   	i--; j--;
	   	
	   	v[matNo][(i*n)+j] = 0;
	     } 

DispGraph : DISP ID {
		int matNo = mp[$2];
	   	int n = size[$2];
	   	
	   	printf("\n");
	   	
	   	for(int i=0; i<n; i++)
	   	{
	   		for(int j=0; j<n; j++)
	   		{
	   			printf("%d ", v[matNo][(i*n)+j]);
	   		}
	   		printf("\n");
	   	}
	   	printf("\n");
	    }
	    ;

DeclStmt : GRAPH ID {
		if(mp[$2] == 0)
		{
			mp[$2] = no;
			
			no++;
		}
		else
		{
			printf("Declaration for %s already occurs\n", $2);
			return 0;
		}
	   }
	   COMMA NUM {
	   	int matNo = mp[$2];
	   	int n = atoi($5);
	   	size[$2] = n;
	   	
	   	curr = $2;
	   	
	   	for(int i=0; i<n; i++)
	   	{
	   		for(int j=0; j<n; j++)
	   		{
	   			v[matNo].push_back(0);
	   			//printf("%d ", v[matNo][(i*n)+j]);
	   		}
	   		//printf("\n");
	   	}
	   }
	   COMMA LP NUM NUM RP{
	   	int matNo = mp[$2];
	   	int n = atoi($5);
	   	int i = atoi($9), j = atoi($10);
	   	
	   	i--; j--;
	   	
	   	v[matNo][(i*n)+j] = 1;
	   }
	   DeclCont {printf("Declaration of %s\n", $2);
	   }
	 ;

DeclCont : COMMA LP NUM NUM RP {
		int matNo = mp[curr];
	   	int n = size[curr];

	   	int i = atoi($3), j = atoi($4);
	   	i--; j--;
	   	
	   	v[matNo][(i*n)+j] = 1;
	   }
	   DeclCont
	 |
	 ;

%%

int main(int argc, char** argv)
{
	yyparse();
	return 0;
}
