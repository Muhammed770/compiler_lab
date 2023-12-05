%%
a { return A; }
b { return B; }
c { return C; }
d { return D; }
\n { return END; }
[^abcd\n] { return ERR; }
%%
int yywrap()
{
	return 1;
}
