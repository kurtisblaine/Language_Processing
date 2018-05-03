dig     [0-9] 
char    [a-zA-Z]
sop     [("+")("-")("*")("%")("<")(">")("/")]
ge		("<=")
le      (">=")
ee		("==")
ne		("!=")

%%

{dig}+    					{   printf("n");   }
{char}+   					{   printf("s");   }
" "+    				    {   printf("w");   }
"\n"      					{   printf("w\n"); }
{sop} 						{   printf("o");   }
{ge}						{   printf("o");   }
{le}						{   printf("o");   }
{ee}						{   printf("o");   }
{ne}						{   printf("o");   }
.         					{   printf("p");   }

%%
