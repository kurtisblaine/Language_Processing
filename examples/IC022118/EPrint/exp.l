

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


#include "exp.tab.h"

%}


DIGIT  [0-9]

%%

{DIGIT}+  { strcpy(yylval.str,yytext); return NUMBER; } 

[a-zA-Z][a-zA-Z0-9]*  { strcpy(yylval.str, yytext); return ID; }

:=  { return ASSIGN; }


[ \t]     /* ignore whitespace */


<<EOF>>   yyterminate();  /* signal end of dialogue */

\n       return yytext[0];
.        return yytext[0];

%%

