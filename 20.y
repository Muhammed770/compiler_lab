%{ 
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <errno.h>
	#include <unistd.h>
	int yylex(void); 
	void yyerror(char *);
	#define YYSTYPE char*
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
	expr TERMINATE { printf("%s\n",$1); free($1); YYACCEPT; }
	| error TERMINATE { printf("Invalid expression.\n"); YYACCEPT; }
	;
expr:
	term { $$ = malloc(strlen($1)+1); strcpy($$,$1); free($1); }
	| expr PLUS term { int len = strlen($1)+strlen($3)+4; $$ = malloc(len); snprintf($$, len, "%s %s +", $1, $3); free($1); free($3); }
	| expr MINUS term { int len = strlen($1)+strlen($3)+4; $$ = malloc(len); snprintf($$, len, "%s %s -", $1, $3); free($1); free($3); }
	;
term:
	factor { $$ = malloc(strlen($1)+1); strcpy($$,$1); free($1); }
	| term MUL factor { int len = strlen($1)+strlen($3)+4; $$ = malloc(len); snprintf($$, len, "%s %s *", $1, $3); free($1); free($3); }
	| term DIV factor { int len = strlen($1)+strlen($3)+4; $$ = malloc(len); snprintf($$, len, "%s %s /", $1, $3); free($1); free($3); }
	;
factor:
	NUMBER { $$ = malloc(strlen($1)+1); strcpy($$,$1); free($1); }
	| PLUS factor { $$ = malloc(strlen($2)+1); strcpy($$,$2); free($2); }
	| MINUS factor { $$ = malloc(strlen($2)+2); snprintf($$, strlen($2)+2, "n%s", $2); free($2); }
	| OPEN expr CLOSE { $$ = malloc(strlen($2)+1); strcpy($$,$2); free($2); }
	;
%% 
#include "20.yy.c"
void yyerror(char *s) { 
	fprintf(stderr, "%s\n", s);  
} 
int main(void) { 
	yyparse(); 
	return 0; 
}
