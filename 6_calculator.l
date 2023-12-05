%{
#include <stdio.h>
#include <stdlib.h>
int op = 0;
float a, b;

void digi();
%}

dig [0-9]+|([0-9]+)"."([0-9]+)
add "+"
sub "-"
mul "*"
div "/"
pow "^"
ln \n

%%
{dig} { digi(); }
{add} { op = 1; }
{sub} { op = 2; }
{mul} { op = 3; }
{div} { op = 4; }
{pow} { op = 5; }
{ln} { printf("The Answer is: %f\n\n", a); }

%%

void digi() {
    if (op == 0)
        a = atof(yytext);
    else {
        b = atof(yytext);
        switch (op) {
            case 1:
                a = a + b;
                break;
            case 2:
                a = a - b;
                break;
            case 3:
                a = a * b;
                break;
            case 4:
                if (b != 0) // Check for division by zero
                    a = a / b;
                else
                    printf("Error: Division by zero\n");
                break;
            case 5:
                d=a;
                for (int i = 1; i < b; i++) // Fix the exponentiation loop
                    a *= d;
                break;
        }
        op = 0;
    }
}
int yywrap(){
return 1;
}

int main() {
    yylex();
    return 0;
}




//squ