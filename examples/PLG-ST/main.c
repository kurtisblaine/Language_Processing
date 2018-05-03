#include <stdio.h>
#include <stdlib.h>
#include <string.h>



#include "symtab.c"

int main()
{
 char s[10];
 int i;

 for (i = 0; i < 5; ++i)
 {
  printf("Enter sym: ");
  scanf("%s", s);
  addtab( s ); 
 }
 showtab();
 return 0;
}
