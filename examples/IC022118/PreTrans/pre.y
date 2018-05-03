
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
                              printf ("%s IS %s\n", $1.str, $3.str); }
    ;

expression
    : expression '+' term   { strcpy($$.str, "+ ");
                              strcat($$.str, $1.str);
                              strcat($$.str, $3.str);} 
    | term                  { strcpy($$.str, $1.str); } 
    ;
term
    : term '*' factor       { strcpy($$.str, "* ");
                              strcat($$.str, $1.str);
                              strcat($$.str, $3.str);} 
    | factor                { strcpy($$.str, $1.str); } 
    ;

factor
    :  NUMBER               { strcpy($$.str, $1.str);  
                              strcat($$.str, " "); } 
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

