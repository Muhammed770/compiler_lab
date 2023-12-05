%{ 
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <errno.h>
	#include <unistd.h>
	int yylex(void); 
	void yyerror(char *);
	#define YYSTYPE float
%}
%token NUMBER
%token PLUS
%token MINUS
%token MUL
%token DIV
%token OPEN
%token CLOSE
%token TERMINATE
%token ERR
%%
line:
	expr TERMINATE { printf("Answer: %f\n",$1); YYACCEPT; }
	| TERMINATE { printf("Answer: 0\n"); YYACCEPT; }
	;
expr:
	term { $$ = $1; }
	| expr PLUS term { $$ = $1 + $3; }
	| expr MINUS term { $$ = $1 - $3; }
	;
term:
	factor { $$ = $1; }
	| term MUL factor { $$ = $1 * $3; }
	| term DIV factor { $$ = $1 / $3; }
	;
factor:
	NUMBER { $$ = $1; }
	| PLUS factor { $$ = $2; }
	| MINUS factor { $$ = -$2; }
	| OPEN expr CLOSE {$$ = $2; }
	;
%% 
#include "19.yy.c"
void yyerror(char *s) { 
	fprintf(stderr, "%s\n", s);  
} 
int main(void) { 
	yyparse(); 
	return 0; 
}
