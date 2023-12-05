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
%token D
%token END
%token ERR
%%
line:
	expr END { printf("Valid string\n"); YYACCEPT; }
	| error END { printf("Invalid string\n"); YYACCEPT; }
	;
expr:
	A exprd
	| sec
	;
exprd:
	expr D
	;
sec:
	B secc
	|
	;
secc:
	sec C
	;
%%
#include "12.yy.c"
void yyerror(char *s) { 
	//fprintf(stderr, "%s\n", s);  
} 
int main(void) { 
	yyparse(); 
	return 0; 
}
