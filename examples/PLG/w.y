
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct 
{
 char thestr[25];
 int ival;
 int ttype;
}tstruct ; 

#define YYSTYPE  tstruct 

int yylex();
void yyerror( char *s );

%}

%token tstart  
%token tfinish   
%token tbegin  
%token tend  
%token tint  
%token tfloat  
%token tbool  
%token tprint  
%token tprintln  
%token tif  
%token telse
%token twhile  
%token tlt  
%token tgt  
%token teq  
%token tne
%token tfalse  
%token ttrue  
%token tassign  
%token tstrlit  
%token tid  
%token tnum  
%token tor
%token tand


%%

p : prog ;

prog : tstart  tfinish    {}
 |  tstart DL SL tfinish  {}
 ;

DL : DL D    {}
   | D       {}
   ;

D : IDL ':' type ';'  {} 
  ;

IDL : IDL ',' tid   {} 
    | tid           {}
    ;

type: tint {} | tfloat {} | tbool {} ;

SL :  SL S   {}
   | S       {}
   ;

S : tprint tstrlit ';'    { }
  | tprint tid ';'        { }
  | tprintln ';'          { }
  | tid tassign expr ';'  { }
  | tif '(' cexpr ')' ':' SL '~'  {printf("IF\n"); }
  | tif '(' cexpr ')' ':' SL '~' telse ':' SL '~'  {printf("IFELSE\n"); }
  | twhile '(' cexpr ')' ':' SL '~'  {printf("WHILE\n"); }
  | error ';'             { }
  ;

cexpr : expr tgt expr {}
      | expr tlt expr {}
      | expr teq expr {}
      | expr tne expr {} 
      | tor cexpr '|' cexpr {printf("tor\n");}
      | tand cexpr '|' cexpr {printf("tand\n");}
      | '(' cexpr ')' {}
;	

expr : expr '+' term { }
  |  term            { }
  ;

term : term '*' factor { }
  | factor             { }
  ;

factor : tid  { }
 | tnum       { }
 | ttrue      { }
 | tfalse     { }
 ;

%%


int main ()
{
  yyparse ();
  printf("---------------------\n");
}

void yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("\terror: %s\n", s);
  printf ("ERROR: %s at line ???\n", s);
}

