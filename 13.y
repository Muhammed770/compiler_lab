%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int yylex(void); 
void yyerror(char *);
%}
%token A
%token B
%token C
%token END
%token ERR
%%
line:
	expl expr END { printf("Valid string\n"); YYACCEPT; }
	| error END { printf("Invalid string\n"); YYACCEPT; }
	;
expl:
	A expb
	| A B
	;
expb:
	expl B
	;
expr:
	B expc
	| B C
	;
expc:
	expr C
	;
%%
#include "13.yy.c"
void yyerror(char *s) { 
	//fprintf(stderr, "%s\n", s);  
} 
int main(void) { 
	yyparse(); 
	return 0; 
}
