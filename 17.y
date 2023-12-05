%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int yylex(void); 
void yyerror(char *);
%}
%token WHILE
%token FOR
%token DO
%token OPEN_CURLY
%token CLOSE_CURLY
%token OPEN
%token CLOSE
%token END
%token COMMA
%token SEMICOLON
%token IDENTIFIER
%token OPERATOR
%token CHAR
%token NUMBER
%%
line:
	loop END { printf("Valid string\n"); YYACCEPT; }
	| error END { printf("Invalid string\n"); YYACCEPT; }
	;
loop:
	WHILE OPEN expr CLOSE body
	| FOR OPEN stmt expr SEMICOLON expr CLOSE body
	| DO body WHILE OPEN expr CLOSE SEMICOLON
	;
expr:
	IDENTIFIER OPERATOR rhs
stmt:
	expr SEMICOLON
	| IDENTIFIER expr SEMICOLON
	| SEMICOLON
	;
body:
	stmt
	| OPEN_CURLY stmt_group CLOSE_CURLY 
	;
stmt_group:
	
	| stmt stmt_group
	;
rhs:
	IDENTIFIER
	| NUMBER
	;

%%
#include "17.yy.c"
void yyerror(char *s) { 
	//fprintf(stderr, "%s\n", s);  
} 
int main(void) { 
	yyparse(); 
	return 0; 
}
