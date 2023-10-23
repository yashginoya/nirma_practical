%{
#include<stdio.h>
#include "y.tab.h"

%}

alpha [A-Za-z]
digit [0-9]
%%

[ \t\n]   
if    return IF;
else    return ELSE;
elseif    return ELSEIF;
for    return FOR;
{digit}+    return NUM;
{alpha}({alpha}|{digit})*    return ID;
"{"    return '{';
"}"    return '}';
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
"||"    return OR;
"&&"    return AND;
.    return yytext[0];
%%
int yywrap()
{
return 1;
}
