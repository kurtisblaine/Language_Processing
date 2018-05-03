
go: lex.yy.c pre2in.tab.c 
	gcc pre2in.tab.c lex.yy.c -lfl -ly -o go 

lex.yy.c: pre2in.l
	flex pre2in.l

pre2in.tab.c: pre2in.y
	bison -dv pre2in.y

clean:
	rm -f lex.yy.c 
	rm -f pre2in.output
	rm -f pre2in.tab.h
	rm -f pre2in.tab.c
	rm -f go

