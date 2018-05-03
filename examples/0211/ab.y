
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct 
{
 int acnt;
 int bcnt;
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
    |  S '\n'            {  printf("   Value: %d\n", $1.ival); 
                            printf("----------------------\n");
                         }
    ;


S : A B  {
	 if($1.acnt == $2.bcnt ){
		 printf("yes\n");
		 $$.ival = 1  ;
        }
	else{
		$$.ival = 0;
		printf("no\n");}
 }

A : A 'a'    {  $$.acnt = $1.acnt + 1; }
  | 'a'      { $$.acnt = 1; }
  ;
B : B 'b'    { $$.bcnt = $1.bcnt + 1; }
  | 'b'      { $$.bcnt = 1; }
  ;


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

