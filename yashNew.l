%{#include<stdio.h>
int ch = 0,word = 0,line=0;
%}
delim [\t]+
%%
\n {ch++;word++;line++;}
^{delim} {ch += yyleng;}
{delim} {ch += yyleng; word++;}
. {ch++;}
%%
main(){
	yylex();
	printf("%d %d %d",ch,word,line);
}
