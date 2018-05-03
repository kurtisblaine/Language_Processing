#include <stdio.h>
#include <string.h>

int main()
{
        char line[1024];
        int len;
        int alphabets;
        int digits;
        int spaces;
        int alphanumerics;
        int hashtag;
        int atsequence;
        int i = 0;

        printf("Enter a phrase: ");
        fgets( line, 1024, stdin);


        while(line[i] != '\0'){
        	if(line[i] >= '0' && line[i] <= '9'){
        		digits++;
        	}

        	else if((line[i] >= 'a' && line[i] <= 'z') || (line[i] >= 'A' && line[i] <= 'Z')){
        		alphabets++;
        	}

        	else if(line[i] == ' '){
        		spaces++;
        	}

        	else if(line[i] == '#'){
        		hashtag++;
        	}

        	else if(line[i] == '@'){
        		atsequence++;
        	}

        	i++;
        }

        // remove trailing newline
        len = strlen( line );
       // len--;
        line[len] = '\0';

        printf("\ncharacters: %d\n", len);
        // printf("characters: %d\n", alphabets);
          printf("digits: %d\n", digits);
          printf("spaces: %d\n", spaces);
          alphanumerics = digits + alphabets;
           printf("alphanumerics: %d\n", alphanumerics);
            printf("hashtag: %d\n", hashtag);
            printf("consequative @'s: %d\n", atsequence);


       	return 0;
}
