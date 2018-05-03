
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
void yyerror(const char *s );

#include "symtab.c"


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
%token twhile  
%token tlt  
%token tgt  
%token teq  
%token tfalse  
%token ttrue  
%token tassign  
%token tstrlit  
%token tid  
%token tnum  

%define locations



%%

p : prog ;

prog : tstart  tfinish    {}
 |  tstart DL SL tfinish  {  showtab(); }
 ;

DL : DL D    {}
   | D       {}
   ;

D : IDL ':' type ';'  {} 
  ;

IDL : IDL ',' tid   { addtab( $3.thestr );  } 
    | tid           { addtab( $1.thestr);   }

    ;

type: tint {} | tfloat {} | tbool {} ;

SL :  SL S   {}
   | S       {}
   ;

S : tprint tstrlit ';'      { }
  | tprint tid ';'          { if ( intab( $2.thestr ) > 0 )
                                        printf("LHS sym Yes %s is declared\n", $2.thestr);
                                else
                                        printf("LHS sym ERROR::  %s is NOT declared\n", $2.thestr); }
  | tprintln ';'            { printf("good println\n");}
  | tid tassign expr ';'    { 
				if ( intab( $1.thestr ) > 0 )
					printf("LHS sym Yes %s is declared\n", $1.thestr); 
				else
					printf("LHS sym ERROR::  %s is NOT declared\n", $2.thestr); 

							}
  | tif '(' bexpr ')' tbegin SL tend ';'  { printf("good if\n");}
  | error ';'               { }
  ;

bexpr: expr tgt expr  { printf(" bexpr1 \n"); }
     | expr tlt expr  { printf(" bexpr2 \n"); }
     | expr teq expr  { printf(" bexpr3 \n"); }
     ;

expr : expr '+' term { }
  |  term            { }
  ;

term : term '*' factor { }
  | factor             { }
  ;

factor : tid  {
				if ( intab( $1.thestr ) > 0 )
					printf("Yes %s is declared\n", $1.thestr); 
				else
					printf("ERROR::  %s is NOT declared\n", $1.thestr); 
              }
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


