%{
#include <stdio.h>
%}

%%
if|else|int|float|do|while|break|continue|goto|main|const|for|union|double|include{
    printf("\n%s is a keyword", yytext);
}
[a-zA-Z]([a-zA-Z]|[0-9])* {
    printf("\n%s is an identifier", yytext);
}
[0-9]+ {
    printf("\n%s is an integer constant", yytext);
}
[0-9]*[.][0-9]+ {
    printf("\n%s is a floating-point constant", yytext);
}
[-+*/^<>=]+ {
    printf("\n%s is an operator", yytext);
}
[ \t]+ {
    // Ignore whitespace
}
; {
    printf("\n%s is a separator", yytext);
}
. {
    printf("\nUnrecognized token: %s", yytext);
}

%%

int main() {
    FILE *input_file = fopen("hello.c", "r");
    if (!input_file) {
        fprintf(stderr, "Failed to open input file.\n");
        return 1;
    }

    yyin = input_file;
    yylex();
    fclose(input_file);
    return 0;
}

int yywrap() {
    return 1;
}
