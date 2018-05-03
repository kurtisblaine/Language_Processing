
%{
 #include <stdio.h>

int yylex();
void yyerror( char *s);
%}

%%

 
H : G
  | H G
  ;


G :  S '\n'  { printf("%d a's\n", $$);  }
  ;

S : 'a'    {$$ = 1;  }           
  | S 'a'  {$$ = $1 + 1;  } 
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

void yyerror( char *s )
{
}
