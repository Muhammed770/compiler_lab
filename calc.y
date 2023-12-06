%{
#include<stdio.h>
int flag=0;
int yylex(void);
void yyerror(const char *s);
%}

%token Num

%left '+''-'
%left '*''/''%'
%left '('')'

%%

S:E{
	printf("\nResult=%d\n",$$);
	return 0;
}
E:E'+'E {$$=$1+$3;}
|E'-'E {$$=$1-$3;}
|E'*'E {$$=$1*$3;}
|E'/'E {$$=$1/$3;}
|E'%'E {$$=$1%$3;}
|'('E')' {$$=$2;}
|Num {$$=$1;}

;
%%
int main()
{
	printf("\nenter the arithmetic expression: ");
	yyparse();
	if(flag==0)
		printf("entered expression is valid");	
	return 0;
}

void yyerror(const char *s)
{
	printf("\nenter the arithmetic expression is invalid\n");
	flag=1;
}

//  to run code type following commands in terminal
// $ lex calc.l
// $ yacc -d calc.y
// $ gcc lex.yy.c y.tab.c -ll -ly
// $ ./a.out


// or to create your own object file
// $ lex -o calc.yy.c calc.l
// $ yacc -d -o calc.tab.c calc.y
// $ gcc calc.yy.c calc.tab.c -ll -ly
// $ ./a.out

// or to create your own executable file
// $ lex -o calc.yy.c calc.l
// $ yacc -d -o calc.tab.c calc.y
// $ gcc calc.yy.c calc.tab.c -ll -ly -o calc	
// $ ./calc
