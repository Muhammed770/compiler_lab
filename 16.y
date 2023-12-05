%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int yylex(void); 
void yyerror(char *);
%}
%token STRUCT
%token IDENTIFIER
%token COMMA
%token SEMICOLON
%token ASTERISK
%token END
%token ERR
%left ASTERISK
%left IDENTIFIER
%%
line:
	stmt END { printf("Valid string\n"); YYACCEPT; }
	| error END { printf("Invalid string\n"); YYACCEPT; }
	;
stmt:
	STRUCT IDENTIFIER rest
	| IDENTIFIER rest
	;
rest:
	varlist SEMICOLON
	;
varlist:
	var COMMA varlist
	| var
	;
var:
	asks IDENTIFIER
	;
asks:
	asks ASTERISK
	| 
	;

%%
#include "16.yy.c"
void yyerror(char *s) { 
	//fprintf(stderr, "%s\n", s);  
} 
int main(void) { 
	yyparse(); 
	return 0; 
}
