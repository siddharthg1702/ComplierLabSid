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

%token LP RP ADD SUB MUL DIV ASSIGN SEMI MOD ID GT LT GE LE NEQ EQ LAND LOR LNOT BAND BOR BXOR SL SR ADDASSIGN SUBASSIGN MULASSIGN DIVASSIGN MODASSIGN SLASSIGN SRASSIGN BANDASSIGN BORASSIGN BXORASSIGN BNOT INC DEC

%type<str> LP RP ADD SUB MUL DIV ASSIGN SEMI MOD ID GT LT GE LE NEQ EQ LAND LOR LNOT BAND BOR BXOR SL SR ADDASSIGN SUBASSIGN MULASSIGN DIVASSIGN MODASSIGN SLASSIGN SRASSIGN BANDASSIGN BORASSIGN BXORASSIGN BNOT INC DEC
%type<s> exp term fact stmt assignment relational logicand logicor bitwiseand bitwiseor bitwisexor equality shift unary postfix_unary

%union {
	char* str;
	struct node* s;
}

%%

stmt
	: assignment SEMI {printf("Parse Tree\n"); printTree($1); printf("\n\n");}
	;
	
assignment
	: assignment ASSIGN logicor		{$$ = makeNode($2,$1,$3);}
	| assignment ADDASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment SLASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment SRASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment SUBASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment MODASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment MULASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment DIVASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment BANDASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment BORASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| assignment BXORASSIGN logicor	{$$ = makeNode($2,$1,$3);}
	| logicor						{$$ = $1;}
	;

logicor
	: logicand LOR logicand		{$$ = makeNode($2,$1,$3);}
	| logicand	 				{$$ = $1;}
	;

logicand
	: logicand LAND bitwiseor	{$$ = makeNode($2,$1,$3);}
	| bitwiseor					{$$ = $1;}
	;

bitwiseor
	: bitwiseor BOR bitwisexor	{$$ = makeNode($2,$1,$3);}
	| bitwisexor				{$$ = $1;}
	;

bitwisexor
	: bitwisexor BXOR bitwiseand {$$ = makeNode($2,$1,$3);}
	| bitwiseand				 {$$ = $1;}
	;

bitwiseand
	: bitwiseand BAND equality 	{$$ = makeNode($2,$1,$3);}
	| equality				 	{$$ = $1;}
	;

equality
	: equality NEQ relational  		{$$ = makeNode($2,$1,$3);}
	| equality EQ relational		{$$ = makeNode($2,$1,$3);}
	| relational					{$$ = $1;}
	;

relational
	: relational GT shift 	{$$ = makeNode($2,$1,$3);}
	| relational LT shift	{$$ = makeNode($2,$1,$3);}
	| relational GE shift 	{$$ = makeNode($2,$1,$3);}
	| relational LE shift	{$$ = makeNode($2,$1,$3);}
	| shift					{$$ = $1;}
	;

shift
	: shift SL exp  	{$$ = makeNode($2,$1,$3);}
	| shift SR exp 		{$$ = makeNode($2,$1,$3);}
	| exp				{$$ = $1;}
	;

exp
	: exp ADD term	{$$ = makeNode($2,$1,$3);}
	| exp SUB term	{$$ = makeNode($2,$1,$3);}
	| term			{$$ = $1;}
	;

term
	: term MUL unary	{$$ = makeNode($2,$1,$3);}
	| term DIV unary	{$$ = makeNode($2,$1,$3);}
	| term MOD unary	{$$ = makeNode($2,$1,$3);}
	| unary			{$$ = $1;}
	;
	
unary 
	: ADD postfix_unary		{$$ = makeNode($1,$2,NULL);}
	| SUB postfix_unary		{$$ = makeNode($1,$2,NULL);}
	| LNOT postfix_unary	{$$ = makeNode($1,$2,NULL);}
	| BNOT postfix_unary	{$$ = makeNode($1,$2,NULL);}
	| INC ID				{$$ = makeNode($1,makeNode($2,NULL,NULL),NULL);}
	| DEC ID				{$$ = makeNode($1,makeNode($2,NULL,NULL),NULL);}
	| postfix_unary			{$$ = $1;}
	;

postfix_unary
	: ID INC				{$$ = makeNode($2,makeNode($1,NULL,NULL),NULL);}
	| ID DEC				{$$ = makeNode($2,makeNode($1,NULL,NULL),NULL);}
	| fact					{$$ = $1;}
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
