
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct 
{
 char str[100];
 int ival;
 
}tstruct ; 

#define YYSTYPE  tstruct 

int yylex();
void yyerror( char *s );

%}


%token  NUMBER
%token  ID 
%token  ASSIGN 

%%

input
    :  /* empty */
    |  input line
    ;

line
    : '\n'
    | ID ASSIGN  expression '\n'     {  
                              printf ("line\n"); }
    ;

expression
    : expression '+' term   { printf("e = e + t\n"); }
    | term                  { printf("e = t\n"); }
    ;
term
    : term '*' factor       { printf("t = t * f\n"); }
    | factor                { printf("t = f\n"); } 
    ;

factor
    :  NUMBER               { printf("f = num:%s\n", $1.str); } 
    ;

%%



void main()
{
  yyparse ();
}

void yyerror(char *s)  /* Called by yyparse on error */
{
  printf ("\terror: %s\n", s);
}

