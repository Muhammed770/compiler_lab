%{
#include <stdio.h>
#include <stdlib.h>

#define MAX_STACK_SIZE 100

double stack[MAX_STACK_SIZE];
int top = -1;

void push(double value) {
    if (top >= MAX_STACK_SIZE - 1) {
        fprintf(stderr, "Stack overflow\n");
        exit(1);
    }
    stack[++top] = value;
}

double pop() {
    if (top == -1) {
        fprintf(stderr, "Stack underflow\n");
        exit(1);
    }
    return stack[top--];
}

%}

DIGIT       [0-9]
WS          [ \t\n]

%%

{DIGIT}+    { push(atof(yytext)); }   /* Push operands onto the stack */
{WS}+       /* Ignore whitespace */
.           {   /* Process operators */
                double op2 = pop();
                double op1 = pop();
                double result;
                switch(yytext[0]) {
                    case '+':
                        result = op1 + op2;
                        break;
                    case '-':
                        result = op1 - op2;
                        break;
                    case '*':
                        result = op1 * op2;
                        break;
                    case '/':
                        if (op2 == 0) {
                            fprintf(stderr, "Division by zero\n");
                            exit(1);
                        }
                        result = op1 / op2;
                        break;
                    default:
                        fprintf(stderr, "Invalid operator: %s\n", yytext);
                        exit(1);
                }
                push(result);   /* Push the result back onto the stack */
            }

%%
int yywrap(){
	return 1;
}
int main() {
    yylex(); /* Start the lexer */
    if (top == 0) {
        printf("Result: %f\n", stack[0]);
        return 0;
    } else {
        fprintf(stderr, "Invalid expression\n");
        return 1;
    }
}
