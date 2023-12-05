%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int yylex(void); 
void yyerror(char *);
%}
%token STRUCT
%token OPEN_CURLY
%token CLOSE_CURLY
%token OPEN
%token CLOSE
%token END
%token ASTERISK
%token COMMA
%token SEMICOLON
%token IDENTIFIER
%token OPERATOR
%token CHAR
%token NUMBER
%%
line:
	func END { printf("Valid string\n"); YYACCEPT; }
	| error END { printf("Invalid string\n"); YYACCEPT; }
	;
func:
	type IDENTIFIER OPEN params CLOSE body
	| type IDENTIFIER OPEN CLOSE body
	;
type:
	STRUCT IDENTIFIER asks
	| IDENTIFIER asks
	;
asks:
	asks ASTERISK
	|
	;
params:
	type IDENTIFIER COMMA params
	| type IDENTIFIER
	;
expr:
	IDENTIFIER OPERATOR rhs
	| IDENTIFIER ASTERISK rhs
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
#include "18.yy.c"
void yyerror(char *s) { 
	//fprintf(stderr, "%s\n", s);  
} 
int main(void) { 
	yyparse(); 
	return 0; 
}
