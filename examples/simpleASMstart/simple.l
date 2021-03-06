
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


#include "simple.tab.h"

%}


LET  [a-zA-Z]
DIG  [0-9]

%%

simple   { return SIMPLE; }
end      { return END;    }
if       { return IF;     }
while    { return WHILE;  }
get      { return GET;    }
int      { return INT;    }
float    { return FLOAT;  }
"<"      { strcpy( yylval.str, "LT" ) ; return RELOP;  }
"<="     { strcpy( yylval.str, "LE" ) ; return RELOP;  }
">"      { strcpy( yylval.str, "GT" ) ; return RELOP;  }
">="     { strcpy( yylval.str, "GE" ) ; return RELOP;  }
"=="     { strcpy( yylval.str, "EQ" ) ; return RELOP;  }
"!="     { strcpy( yylval.str, "NE" ) ; return RELOP;  }


{DIG}+   { strcpy( yylval.str, yytext) ;  return NUM;  }
{LET}+   { strcpy( yylval.str, yytext) ;  return ID;   }  

[ \t\n]     /* ignore whitespace */

<<EOF>>   yyterminate();  /* signal end of dialogue */

.        return yytext[0];

%%

