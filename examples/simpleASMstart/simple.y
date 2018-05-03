
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
void yyerror( const char *s );




int tc=1, lc=1;
int ltop, lcheck, lend;
%}

%error-verbose


%token SIMPLE
%token END
%token IF
%token WHILE 
%token GET
%token INT
%token FLOAT
%token NUM
%token ID
%token RELOP




%%

program : SIMPLE  DL  SL  END  
 {
   printf("//------------------\n\n");
   printf("%s", $2.str);
   printf("%s", $3.str);
   printf("\n");
   printf("//------------------\n");
 }

       ;

DL : DL D    { sprintf($$.str, "%s%s", $1.str, $2.str); }
   | D       { sprintf($$.str, "%s", $1.str);           }
   ;

D : type ':' ID  ';'   {sprintf($$.str, " declare %s as %s\n", $3.str, $1.str);}
  ;

type : INT             { sprintf($$.str, "integer"); }
     | FLOAT           { sprintf($$.str, "real");    }
     ;


block :  '{' SL '}'    { sprintf($$.str, "%s", $2.str);  }
      |  S             { sprintf($$.str, "%s", $1.str);  }
      ;

SL : S SL  { sprintf($$.str, "%s%s", $1.str, $2.str); }
   | S     { sprintf($$.str, "%s", $1.str);           }
   ;


S : ID '=' E ';' { 
		   sprintf($$.str, "%s store %s, t%d\n",
                                   $3.str, $1.str, $3.ival);
                   printf("ASTMT: %s\n", $$.str );
                 }
  ;

S : WHILE ce block  { 
		  sprintf($$.str, "L%d:\n %s jumpfalse L%d\n %s jump L%d\n L%d:\n"
		, lc , $2.str, lc+1, $3.str, lc , lc+1 );
		 lc = lc + 2;  
                  printf("WHILE: %s\n", $$.str );
                 } 
  ;

S : IF ce block  { 
		   sprintf($$.str, "%s jumpfalse L%d\n %s L%d:\n ", $2.str, lc, $3.str, 
			lc );
		   ++lc;
                   printf("IF: %s\n", $$.str );
		                  

  } 
  ;

S : GET ID ';'   { sprintf($$.str, " read %s", $2.str);
                   printf("GSTMT: %s\n", $$.str );
                 }
  ;

ce : '(' E RELOP E ')'   { sprintf($$.str, "%s%s LoadC t%d\n LoadC t%d\n CMP-%s\n", 
                                          $2.str, $4.str, $2.ival, $4.ival, $3.str); 
                         }
   ;


E : E '+' T     { 
		  sprintf($$.str, "%s%s add t%d, t%d, t%d\n",
                                  $1.str, $3.str, tc, $1.ival, $3.ival);
                  $$.ival = tc;
                  tc++;
                }
  | T           { strcpy( $$.str, $1.str ); 
                  $$.ival = $1.ival; 
                }
  ;
T : T '*' F     { sprintf($$.str, "%s%s mul t%d, t%d, t%d\n", 
                                  $1.str, $3.str, tc, $1.ival, $3.ival); 
                  $$.ival = tc;
                  tc++;
                } 
  | F           { strcpy( $$.str, $1.str ); 
                  $$.ival = $1.ival; 
                }
  ;
F : NUM         { sprintf($$.str, " loadi t%d, %s\n", tc, $1.str);
                  $$.ival = tc;
                  tc++; 
                } 
  | ID          { sprintf($$.str, " loadv t%d, %s\n", tc, $1.str); 
                  $$.ival = tc;
                  tc++;
                }
  | '(' E ')'   { strcpy( $$.str, $2.str ); 
                  $$.ival = $2.ival; 
                }
  ;

%%


int main()
{
  yyparse ();
}

void yyerror(const char *s)  /* Called by yyparse on error */
{
  printf ("\t myerror: %s\n", s);
}

