%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int yylex(void); 
void yyerror(char *);
%}
%token A
%token B
%token END
%token ERR
%%
line:
	expr END { printf("Valid string\n"); YYACCEPT; }
	| error END { printf("Invalid string\n"); YYACCEPT; }
	;
expr:
	A expr
	| B expr
	| A B B
	;
%%
#include "11.yy.c"
void yyerror(char *s) { 
	//fprintf(stderr, "%s\n", s);  
} 
int main(void) { 
	yyparse(); 
	return 0; 
}
