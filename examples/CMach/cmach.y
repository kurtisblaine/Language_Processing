
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct 
{
 int ival;
 char str[500];
}tstruct ; 

#define YYSTYPE  tstruct 

int yylex();
void yyerror( char *s );
%}


%token    NUM
%token    CLEAR 
%token    ADD
%token    MULT 
%token    SHOW 
%token    GET
%token    MOD
%token    SUB
%token    REP

%%


program
   :  input     { 
                  printf("//------------------\n");
                  printf("#include <stdio.h>\n");
                  printf("int main()\n");
                  printf("{\n");
                  printf("int x;\n");
                  printf("%s", $1.str);
                  printf("return 0;\n");
                  printf("}\n");
                  printf("//------------------\n");
                }
   ;

input
    :  /* empty */
    |  input line  
                   {
                     strcpy( $$.str, $1.str);
                     strcat( $$.str, $2.str);  
                   }
    ;

line
    : ';'
    |  cmd ';'           
                   {
                     strcpy( $$.str, $1.str);
                   }
    ;

cmd 
  :  CLEAR {strcpy( $$.str, "x = 0;\n");             }
  |  SHOW  {strcpy( $$.str, "printf(\" %d\\n\", x);\n" ); }
  |  GET   {strcpy( $$.str, "scanf(\" %d\",&x);\n" ); }
  |  REP NUM cmd {
            strcpy( $$.str, "for (int k = 0; k < ");
            strcat( $$.str, $2.str);
            strcat ( $$.str, " , k++)\n");
	    strcat ( $$.str, "{\n" );
	    strcat ( $$.str, $3.str);
	    strcat ( $$.str, "}\n");
	   }
  |  ADD NUM
           { 
            strcpy( $$.str, "x = x + ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
           } 
  |  MULT NUM
           { 
            strcpy( $$.str, "x = x * ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
           } 
   |  SUB  NUM
           {
            strcpy( $$.str, "x = x - ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
           }  
   |  MOD  NUM
           {
            strcpy( $$.str, "x = x % ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
           }
;


%%


int main()
{
  yyparse();
  return 0;
}


void yyerror(char *s)  /* Called by yyparse on error */
{
  printf ("\terror: %s\n", s);
}


