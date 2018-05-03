
go: lex.yy.c counter.tab.c 
	gcc counter.tab.c lex.yy.c -lfl -ly -o go 

lex.yy.c: counter.l
	flex counter.l

counter.tab.c: counter.y
	bison -dv counter.y

clean:
	rm -f lex.yy.c 
	rm -f counter.output
	rm -f counter.tab.h
	rm -f counter.tab.c

