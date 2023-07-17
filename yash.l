%{#include<stdio.h>
%}
%%
[0-9]+ {printf("Hi");}
[0-9]*"."[0-9]* {printf("float");}
[_a-zA-z][_a-zA-z0-9]* {printf("Identifier");}
%%
main(){
	yylex();
}
