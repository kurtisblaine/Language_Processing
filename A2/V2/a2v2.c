#include <stdio.h>
#include <string.h>

int main()
{

    int c, d;
    
	printf("Start\n");
	
	while ( (c = getchar()) != EOF)
	{

			if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')){
                printf("s");
                while(((c = getchar()) >= 'a' && c  <= 'z') || (c >= 'A' && c <= 'Z'));
           
            }    

        	if(c == '\n'){

                printf("w\n");  

        	}

        	if(c == ' '){
                printf("w");
        	    
        	}

        	if(c >= '0' && c <= '9'){
                printf("n");
              //  while(((c = getchar()) >= '0') && (c <= '9') );      	
            }


            if ( (c == '+') || (c == '-') || (c == '*') || (c == '/') || (c == '%') || (c == '<') || (c == '>') || (c == '!') || (c == '=') )
            {
                if((d = getchar()) == '='){
                    printf("o");
                }
                else{
                    d = c;
                    printf("o");
                }

            }
            

		
	}
	printf("\nEnd\n");

	return 0;
}
