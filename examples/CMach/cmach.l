

%{

typedef struct
{
 int ival;
 char str[100];
}tstruct ;

#define YYSTYPE  tstruct

#include "cmach.tab.h"

%}

DIGIT  [0-9]

%%

{DIGIT}+  {
          yylval.ival = atoi(yytext); 
          strcpy(yylval.str, yytext);
          return NUM; }

clr    {return CLEAR; }
plus   {return ADD; }
times  {return MULT; }
disp   {return SHOW; }
get    {return GET;}
sub    {return SUB;}
mod    {return MOD;}
rep    {return REP;}

[ \t\n]     /* ignore whitespace */


<<EOF>>   yyterminate();  /* signal end of dialogue */

;       return yytext[0];
.        /* return yytext[0]; */

%%

