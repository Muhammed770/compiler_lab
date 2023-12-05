%%
a { return A; }
b { return B; }
c { return C; }
\n { return END; }
[^abc\n] { return ERR; }
%%
int yywrap()
{
	return 1;
}
