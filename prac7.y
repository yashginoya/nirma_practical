%{
#include <stdio.h>
#include <stdlib.h>
%}

%token ID NUM IF '{' '}' LE GE EQ NE OR AND ELSE ELSEIF FOR
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%left '!'
%%
Z:Ifelse|S;
Ifelse: ST{
            printf("Valid If else Statement\n");
            return 0;
      };

S: A {
         printf("Valid for loop Statement.\n");exit(0);
      };

ST:IF '(' E2 ')' '{' ST1';''}' ELSE '{' ST1';''}'
  |IF '(' E2 ')' '{' ST1';''}' G ELSE '{' ST1';''}'
  |IF '(' E2 ')' '{' ST1';''}'
  |IF '(' E2 ')' '{' '}'
  
G:ELSEIF '(' E2 ')' '{' ST1';''}'
 |ELSEIF '(' E2 ')' '{' ST1';''}' G

A: FOR '(' E ';' E2 ';'E ')' B;

B:'{' 
D '}'
 |E';'
 |A
 |
 ;
 
D:D D
 |E';'
 |A
 |
 ;
 
 
ST1:ST
   | E
   |
   ;
   
E  : ID'='E
   | E'+'E
   | E'-'E
   | E'*'E
   | E'/'E
   | E'<'E
   | E'>'E
   | E LE E
   | E GE E
   | E EQ E
   | E NE E
   | E OR E
   | E AND E
   | ID
   | NUM
   | E'+''+'
   | E'-''-'
   ;

E2 : E'<'E
   | E'>'E
   | E LE E
   | E GE E
   | E EQ E
   | E NE E
   | E OR E
   | E AND E
   | ID
   | NUM
   ;

%%

void main()
{
  printf("Enter the exp : ");
  yyparse();
}
void yyerror(){
   printf("\nEntered Statement is Invalid\n\n");
}
