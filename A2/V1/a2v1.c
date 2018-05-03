#include <stdio.h>
#include <string.h>
#define MAX 1024
int main()
{
	int c;
	int newC;

	printf("Start\n"); 
	c = getchar();
	
	while ( c != EOF )
	{
			if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')){
                
        		printf("L");
        	}

        	else if(c == '\n'){
        		printf("W\n");
        	}

        	 else if(c == ' '){
        		printf("W");
        	}

        	 else if(c >= '0' && c <= '9'){
        		printf("D");
        	}

        	else{
        		printf("P");
       		}

       	c = getchar();
	}
	printf("\nEnd\n");

	return 0;
}
