
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct 
{
 int ival;
 char str[100];
}tstruct ; 

#define YYSTYPE  tstruct 

int yylex();
void yyerror( char *s );

%}


%token    NUMBER

%%

input
    :  /* empty */
    |  input line
    ;

line
    : '\n'
    |  expression '\n'            {  printf("   Infix Expression: %s\n", $1.str); 
                                     printf("----------------------\n");
                                     }
    ;

expression
    : '+' expression expression    {
				     strcpy ($$.str, "(" );
				     strcat ($$.str, $2.str);
				     strcat($$.str, " + ");
				     strcat ($$.str, $3.str); 
				     strcat ($$.str, ")" );
                                   }
    | '*' expression expression    {
				     strcpy ($$.str, "(" );
				     strcat ($$.str, $2.str);
                                     strcat($$.str, " * ");
                                     strcat ($$.str, $3.str); 
				     strcat ($$.str, ")" );                                  
				   }
    | factor                       {  strcpy( $$.str, $1.str);
                                   }
    ;

factor
    :  NUMBER               { strcpy( $$.str, $1.str);
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

