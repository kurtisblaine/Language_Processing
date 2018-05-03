
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct 
{
 int wc;
 int nc;
 int ival;
 char str[100];
}tstruct ; 

#define YYSTYPE  tstruct 

int yylex();
void yyerror( char *s );

%}


%%

input
    :  /* empty */
    |  input line
    ;

line
    : '\n'
    |  S '\n'            {  printf(" WC: %d  NC: %d\n", $1.wc, $1.nc ); 
                                     printf("----------------------\n");
                         }
    ;


S : S '.' N     { $$.wc = $1.wc; $$.nc = $1.nc + 1;   }
  | S '.' W     { $$.wc = $1.wc + 1; $$.nc = $1.nc;    }
  | N           { $$.wc = 0; $$.nc = 1;                }
  | W           { $$.wc = 1; $$.nc = 0;              }
  ;

N : N D | D;
D : '0'|'1'|'2';

W : W L | L;
L : 'a'|'b'|'c';


%%

int yylex()
{
 int c;
 c = getchar();
 return c;
}

void main()
{
 yyparse();
}

void yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("\t  my error goes here error: %s\n", s);
  yyparse();
}

