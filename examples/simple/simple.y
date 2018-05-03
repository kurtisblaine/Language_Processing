
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct 
{
 char str[1024];
 int ival;
 
}tstruct ; 

#define YYSTYPE  tstruct 

int yylex();
void yyerror( char *s );

%}

/* %error-verbose  */

%token SIMPLE
%token END
%token IF
%token GET
%token INT
%token FLOAT
%token NUM
%token ID
%token RELOP


%%

program: SIMPLE  DL  SL  END  { printf("\n\nProg:: %s\n", $3.str); }
       ;

DL : DL D
   | D
   ;

D: type ':' ID  ';'  { printf("Dec %s\n", $3.str); }
 ;

type: INT | FLOAT
    ;


block:  '{' SL '}'    { sprintf($$.str, "[ %s ]", $2.str); }
     |  S             { sprintf($$.str, "[ %s ]", $1.str);  }
     ;

SL : S SL  { sprintf($$.str, "[ %s, %s ]", $1.str, $2.str); }
   | S     { sprintf($$.str, "[ %s ]", $1.str);  }
   ;


S : ID '=' E ';'  { printf("Assign %s  %s\n", $1.str, $3.str);
		    sprintf($$.str, "(:=, %s, %s)\n", $1.str, $3.str); 
                    printf("STMT: %s\n", $$.str );
                  }
  ;


E : E '+' T     { sprintf($$.str, "(+, %s, %s)", $1.str, $3.str); }
  | T           { strcpy( $$.str, $1.str ); }
  ;
T : T '*' F     { sprintf($$.str, "(*, %s, %s)", $1.str, $3.str); } 
  | F           { strcpy( $$.str, $1.str ); }
  ;
F : NUM         { strcpy( $$.str, $1.str ); }
  | ID          { strcpy( $$.str, $1.str ); }
  | '(' E ')'   { strcpy( $$.str, $2.str ); }
  ;

%%


int main()
{
  yyparse ();
  return 0;
}

void yyerror(char *s)  /* Called by yyparse on error */
{
  printf ("\t myerror: %s\n", s);
}

