struct "struct"
alpha [_A-Za-z]
digit [0-9]
id {alpha}({alpha}|{digit})*
num {digit}*\.?{digit}+
opr \+|-|\*|\/|=|(==)|(\<=)|(\>=)|(!=)|\>|\<
%%
while { return WHILE; }
for { return FOR; }
do { return DO; }
\{ { return OPEN_CURLY;}
\} { return CLOSE_CURLY;}
\( { return OPEN;}
\) { return CLOSE;}
\n { return END; }
, { return COMMA; }
; { return SEMICOLON; }
[[:space:]] ;
{num} { return NUMBER; }
{id} { return IDENTIFIER; }
{opr} { return OPERATOR; }
. { return CHAR; }
%%
int yywrap()
{
	return 1;
}
