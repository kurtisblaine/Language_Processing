
%{

typedef struct
{
 char thestr[25];
 int ival;
 int ttype;
}tstruct ;

#define YYSTYPE  tstruct

#include "w.tab.h"

%}

DIGIT  [0-9]
UC     [A-Z]
LC     [a-z]
L      [A-Za-z]

%%

START    { return tstart;}
FINISH   { return tfinish;}
BEGIN    { return tbegin;}
END      { return tend;}
INT      { return tint;}
FLOAT    { return tfloat;}
BOOL     { return tbool;}
PRINT    { return tprint;}
PRINTLN  { return tprintln;}
IF       { return tif;}
ELSE     { return telse; }
WHILE    { return twhile;}
EITHER   {return tor;}
BOTH     {return tand;}
LT       { return tlt;}
GT       { return tgt;}
NE       { return tne;}
EQ       { return teq;}
":("     { return tfalse;}
":)"     { return ttrue;}
":="     { return tassign;}

\"([^"]*)\"  { return tstrlit;}
{L}+     { return tid; }
{DIGIT}+ { return tnum; }


@@.*\n   {} /* comments  */   


[ \t]     /* ignore whitespace */

\n       {}

<<EOF>>   yyterminate();  /* signal end of dialogue */

.         return yytext[0];

%%


