%%
a { return A; }
b { return B; }
\n { return END; }
[^abc\n] { return ERR; }
%%
int yywrap()
{
	return 1;
}
