
%{

typedef struct
{
 int ival;
 char str[100];
}tstruct ;

#define YYSTYPE  tstruct

#include "pre2in.tab.h"

%}

DIGIT  [0-9]

%%

{DIGIT}+  {
          strcpy( yylval.str, yytext); 
           return NUMBER; 
          }

[ \t]     /* ignore whitespace */


<<EOF>>   yyterminate();  /* signal end of dialogue */

\n       return yytext[0];
.        return yytext[0];

%%

