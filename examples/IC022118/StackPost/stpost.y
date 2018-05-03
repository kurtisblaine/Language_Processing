
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
    | astmt '\n'     {  printf ("%s\n", $1.str); }
    ;
astmt 
    : ID ASSIGN  expression  {
                              strcpy($$.str, $3.str);
			      strcat($$.str, "store ");
		              strcat($$.str, $1.str);
       	                      strcat($$.str, "\n");
                             }
    ;

expression
    : expression '+' term   { strcpy($$.str, $1.str);
                              strcat($$.str, $3.str);
                              strcat($$.str, "add\n");}
 
    | term                  { strcpy($$.str, $1.str); } 
    ;
term
    : term '*' factor       { 
			                  strcpy($$.str, $1.str);
                           		  strcat($$.str, $3.str);
                             		  strcat($$.str, "mult\n");
			                } 

    | factor                { strcpy($$.str, $1.str); } 

    ;

factor
    :  NUMBER               { strcpy($$.str, "push "); 
                              strcat($$.str, $1.str); 
       	                      strcat($$.str, "\n");
                            } 
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

