%{
#include<stdio.h>
%}
%%
("<"|"<\\")[a-z|A-Z\0-9]*">" { printf(" "); }
%%
int yywrap()
{
	return 1;
}
int main()
{
	yyin=fopen("hello.html","r");
	yyout=fopen("out.txt","w");
	yylex();
	return 0;
}
