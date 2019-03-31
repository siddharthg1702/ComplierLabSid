%token IF LPAREN RPAREN GT LT GEQ LEQ NEQ EQ ID VAL ASS OBRACE CBRACE SEMI WHILE ELSE FOR INC DEC
%{
#include<stdio.h>
%}
%%

if_stmnt
	: IF LPAREN condition RPAREN statement ELSE statement {printf("IF ELSE STATEMENT");}
	| IF LPAREN condition RPAREN statement {printf("IF STATEMENT");}
	;


statement
	: OBRACE expression statement CBRACE
	| expression statement
	| 
	;
	
condition
	: ID rel_op ID 
	| ID rel_op VAL
	| VAL rel_op VAL
	| VAL
	|
	;
	
expression
	: assignment_stmnt
	| if_stmnt
	| while_stmnt
	| for_stmnt
	| SEMI
	;

assignment_stmnt
	: ID ASS ID SEMI
	| ID ASS VAL SEMI
	|
	;

update
	: ID INC
	| ID DEC
	| DEC ID
	| INC ID
	;
	
rel_op
	: LT 
    | LEQ  
    | GT   
    | GEQ  
    | EQ    
    | NEQ   
    ;

while_stmnt
	: WHILE LPAREN condition RPAREN statement {printf("WHILE STATEMENT");}
	;

for_stmnt
	: FOR LPAREN assignment_stmnt condition SEMI update RPAREN statement {printf("FOR STATEMENT");}
	;

%%
#include<stdio.h>
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
