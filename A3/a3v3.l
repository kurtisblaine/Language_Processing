dig     [0-9] 
char    [a-zA-Z]

%%

{dig}+  				{   printf("DEC: %s\n", yytext);   }
"-"{dig}+				{	;}
"0""x"[0-9a-fA-F]*      {   printf("HEX: %s\n", yytext);   }
q						{ exit(0);		}
.						{;}

%%
