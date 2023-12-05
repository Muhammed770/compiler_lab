struct "struct"
alpha [_A-Za-z]
digit [0-9]
id {alpha}({alpha}|{digit})*
%%
{struct} { return STRUCT; }
\* { return ASTERISK; }
\n { return END; }
, { return COMMA; }
; { return SEMICOLON; }
[[:space:]] ;
{id} { return IDENTIFIER; }
. { return ERR; }
%%
int yywrap()
{
	return 1;
}
