
go: lex.yy.c cmach.tab.c 
	gcc cmach.tab.c lex.yy.c -lfl -ly -o go 

lex.yy.c: cmach.l
	flex cmach.l

cmach.tab.c: cmach.y
	bison -dv cmach.y

clean:
	rm -f lex.yy.c 
	rm -f cmach.output
	rm -f cmach.tab.h
	rm -f cmach.tab.c
	rm -f go 

