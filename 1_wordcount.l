%{
    #include<stdio.h>
    int characters=0, sentence=0,word=0;
%}

%%
[a-zA-Z] {characters++;}
[.!?] {sentence++;}
[ \t\n] {if(characters>0) word++;}
%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("enter the paragraph: ");
    yylex();
    printf("\n characters: %d\n words: %d\n sentences: %d\n",characters,word,sentence);
    return 0;
}