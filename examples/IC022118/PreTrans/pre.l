

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


#include "pre.tab.h"

%}


DIGIT  [0-9]
LETTER [a-zA-Z]

%%

{DIGIT}+  { strcpy(yylval.str,yytext); return NUMBER; } 

{LETTER}({LETTER}|{DIGIT})*  { strcpy(yylval.str, yytext); return ID; }

:=  { return ASSIGN; }


[ \t]     /* ignore whitespace */


<<EOF>>   yyterminate();  /* signal end of dialogue */

\n       return yytext[0];
.        return yytext[0];

%%

