%{
#include<stdio.h>
%}
%%
-?(([0-9]+)|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) printf("\nIt is a real number");
.* printf("Not a real number");
%%
int yywrap(void)
{
return 1;
}
int main()
{
printf("Enter a number : ");
yylex();
return 0;
}
