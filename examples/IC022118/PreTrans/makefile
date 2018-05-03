
go: lex.yy.c pre.tab.c 
	gcc pre.tab.c lex.yy.c -lfl -ly -o go 

lex.yy.c: pre.l
	flex pre.l

pre.tab.c: pre.y
	bison -dv pre.y

clean:
	rm -f lex.yy.c 
	rm -f pre.output
	rm -f pre.tab.h
	rm -f pre.tab.c
	rm -f go

