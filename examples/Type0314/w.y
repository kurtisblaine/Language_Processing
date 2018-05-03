
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

prog : tstart  tfinish
 |  tstart DL SL tfinish  {printf("Prog\n");}
 ;

DL :  DL D   {printf("declst\n");}
  | D        {printf("declst\n");}
  ;


D : tid Dtail    { addtab($1.thestr); 
                   addtype($1.thestr, $2.ttype);
                 }
  ;

Dtail : ',' tid Dtail    { addtab($2.thestr); 
                           addtype($2.thestr, $3.ttype); 
                           $$.ttype = $3.ttype; 
                         }
      |  ':' type ';'    {$$.ttype = $2.ttype;}
      ;

type: tint {$$.ttype = 10;} | tfloat {$$.ttype = 20;} | tbool {$$.ttype = 30;} ;

SL :  SL S   {printf("stmtlst\n");}
  | S        {printf("stmtlst\n");}
  ;

S : tprint tstrlit ';'   {printf("print lit\n"); }
  | tprint tid ';'      
              {
                printf("print id\n");
                if ( intab($2.thestr) )
                   printf("%s is declared line %d that\n", $2.thestr, @2.first_line);
                else
                   printf("UNDECLARED:: %s,(line %d) \n", $2.thestr, yyloc.first_line);
              }
  |  tprintln ';'
  |  tid tassign expr ';'  
              {
                printf("assign\n");
                if ( intab($1.thestr) )
                   printf("%s is declared\n", $1.thestr);
                else
                   printf("UNDECLARED:: %s \n", $1.thestr);

                $1.ttype = gettype($1.thestr);
                if ($1.ttype > 0 )
                {
                  if ($1.ttype == $3.ttype)
                        ;
                  else
                     {
                      printf("Incompatible ASSIGN types %d %d\n", $1.ttype, $3.ttype);
                     }
                }
                else 
                    yyerror("Type Error :::");


              }
  | error ';'    {printf("error in statement\n");}
  ;

expr : expr '+' term 
             { 
               if ($1.ttype == 10 && $3.ttype == 10)  $$.ttype = 10; 
               else if ($1.ttype == 20 && $3.ttype == 20)  $$.ttype = 20;
               else $$.ttype = -1;
             }
  |  term      { $$.ttype = $1.ttype; }
  ;

term : term '*' factor
             { 
               if ($1.ttype == 10 && $3.ttype == 10)  $$.ttype = 10; 
               else if ($1.ttype == 20 && $3.ttype == 20)  $$.ttype = 20;
               else $$.ttype = -1; 
             }
  | factor   { $$.ttype = $1.ttype; }
  ;

factor : tid  
              {
                if ( intab($1.thestr) )
                   printf("%s is declared\n", $1.thestr);
                else
                   printf("UNDECLARED:: %s \n", $1.thestr);
                $$.ttype = gettype($1.thestr);
                if ($$.ttype > 0 )
                      ;
                else 
                    yyerror("Type Error :::");
              }
 | tnum   {$$.ttype = 10;}
 | ttrue  {$$.ttype = 30;}
 | tfalse {$$.ttype = 30;}
 ;

%%


int main()
{
  yyparse ();
  printf("---------------------\n");
  showtab();
}


//void yyerror(char *s)  /* Called by yyparse on error */
//{
// printf ("\terror: %s\n", s);
// printf ("ERROR: %s at line %d\n", s, yylineno);
//}


