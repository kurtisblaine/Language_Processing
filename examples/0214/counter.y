
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct 
{
 int ival;
 int nc;
 int wc;
 char str[100];
}tstruct ; 

#define YYSTYPE  tstruct 

%}


%token    NUMBER
%token    WORD 

%%

input
    :  /* empty */
    |  input line
    ;

line
    : '\n'
    |  items '\n'            {  printf(" NC: %d    WC: %d\n", $1.nc,$1.wc ); 
                                     printf("----------------------\n");
                                     }
    ;

items
    :  item              {$$.nc = $1.nc; $$.wc = $1.wc;  }
    |  items item        {$$.nc = $1.nc + $2.nc; $$.wc = $1.wc + $2.wc;  }
    ;

item
    :  NUMBER             {$$.nc = 1; $$.wc = 0; } 
    |  WORD               {$$.nc = 0; $$.wc = 1; } 
    ;

%%


main ()
{
  yyparse ();
}

yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("\terror: %s\n", s);
}

