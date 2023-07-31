%{#include<stdio.h>
%}
%%
[0-9]+ {printf("int");}
[0-9]*"."[0-9]* {printf("float");}
[A-Z] {printf("Capital Character");}
[a-z] {printf("Small Character");}
[a-zA-Z]* {printf("String");}
[_a-zA-Z][_a-zA-Z0-9]* {printf("Identifier");}
[-+*=/] {printf("Operator");}
[//a-zA-Z]* {printf("Single Line Comment");}
%%
main(){
	yylex();
}
