%%
a { return A; }
b { return B; }
\n { return END; }
[^ab\n] { return ERR; }
%%
int yywrap()
{
	return 1;
}
