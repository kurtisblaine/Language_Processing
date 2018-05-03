/*

Read in a line of text  & remove trailing \n
  - allow up to 1024 characters to be in string

Write a function for each & return value to main
  - how many characters
  - how many numeric digits
  - how many spaces
  - how many alphanumeric characters (a-zA-Z0-9)
  - how many  #  symbols in the string  
  - find the length of the longest sequence 
      of @'s in the string

Print results in main, not in the functions

*/


#include <stdio.h>
#include <string.h>

int main()
{
	char line[30];
	int len;

	printf("Enter a phrase: ");
	fgets( line, 30, stdin);

	printf("Read -->%s<--\n", line);

	// remove trailing newline
	len = strlen( line );
	len--;
	line[len] = '\0';

	printf("Now -->%s<--\n", line);
	printf("Len: %d\n", len);

	return 0;
}
