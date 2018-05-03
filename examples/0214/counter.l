
%{

typedef struct
{
 int ival;
 int nc;
 int wc;
 char str[100];
}tstruct ;

#define YYSTYPE  tstruct

#include "counter.tab.h"

%}

DIGIT   [0-9]
LETTER  [a-zA-Z]

%%

{DIGIT}+  {
            yylval.ival = atoi(yytext); 
            return NUMBER; }

{LETTER}+  {
             strcpy( yylval.str, yytext); 
             return WORD; }


[ \t]     /* ignore whitespace */


<<EOF>>   yyterminate();  /* signal end of dialogue */

\n       return yytext[0];
.        return yytext[0];

%%

