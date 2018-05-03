dig     [0-9] 
char    [a-zA-Z]

%%

{dig}    {   printf("D");   }
{char}   {   printf("L");   }
" "      {   printf("W");   }
"\n"	 {   printf("W\n"); }	
.        {   printf("P");   }

%%

