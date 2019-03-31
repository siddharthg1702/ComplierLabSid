%{
	#include<stdio.h>
	#include<stdlib.h>
	typedef struct node
	{
		char* val;
		struct node *left;
		struct node *right;
	} node;

	node* makeNode(char* val, node* left, node* right)
	{
		node* s = (node*)malloc(sizeof(node));
		s->val = val;
		s->left = left;
		s->right = right;
		return s;
	}

	void printTree(node* n)
	{
		if(n)
		{
			printf("%s\n",n->val);
			printTree(n->left);
			printTree(n->right);
		}
	}
%}

%token LP RP ADD SUB MUL DIV ASSIGN SEMI MOD ID

%type<str> LP RP ADD SUB MUL DIV ASSIGN SEMI MOD ID
%type<s> exp term fact stmt assignment

%union {
	char* str;
	struct node* s;
}

%%

stmt
	: assignment {printTree($1);printf("\n");}
	;
	
assignment
	: ID ASSIGN exp {$$ = makeNode($2,makeNode($1,NULL,NULL),$3);printf("\n");}
	;
	
exp
	: exp ADD term	{$$ = makeNode($2,$1,$3);}
	| exp SUB term	{$$ = makeNode($2,$1,$3);}
	| term			{$$ = $1;}
	;

term
	: term MUL fact	{$$ = makeNode($2,$1,$3);}
	| term DIV fact	{$$ = makeNode($2,$1,$3);}
	| term MOD fact	{$$ = makeNode($2,$1,$3);}
	| fact			{$$ = $1;}
	;
	
fact
	: ID			{$$ = makeNode($1,NULL,NULL);}
	| LP exp RP		{$$ = $2;}
	;
	
%%

int main(int argc, char** argv)
{
	FILE *file;
    file = fopen(argv[1], "r");
    yyset_in(file);
    yyparse();
}

int yyerror(char *str) {
	printf("There was an error.");
	return 0;
}
