%{
extern char* yylval;
%}
digit [0-9]
num {digit}*\.?{digit}+
%%
{num} { yylval = malloc(sizeof(char)*yyleng); strcpy(yylval,yytext); return NUMBER; }
\+ {return PLUS;}
- {return MINUS;}
\* {return MUL;}
\/ {return DIV;}
\( {return OPEN;}
\) {return CLOSE;}
\n {return TERMINATE;}
[[:space:]] ;
. {return ERR;}
%%
int yywrap() { return 1; };
