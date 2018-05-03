
struct stelem
{
 char sname[25];
 int  stype; 
};
typedef struct stelem entry;


entry symtab[100];
int nsym;


void addtab( char *s)
{
 nsym++;
 strcpy( symtab[nsym].sname, s);
}

void showtab()
{
 int i;
 for (i = 1; i <= nsym; ++i)
   printf("%d: %s\n", i, symtab[i].sname);
}

int intab( char *s)
{
 int i;
 for ( i = 1; i <= nsym; ++i)
 {
   if ( strcmp(symtab[i].sname, s) == 0)
    return 1;
 }
 return 0;

}



