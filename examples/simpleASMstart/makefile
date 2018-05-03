
go: lex.yy.c simple.tab.c 
	gcc simple.tab.c lex.yy.c -lfl -ly -o go 

lex.yy.c: simple.l
	flex simple.l

simple.tab.c: simple.y
	bison -dv simple.y

clean:
	rm -f lex.yy.c 
	rm -f simple.output
	rm -f simple.tab.h
	rm -f simple.tab.c
	rm -f go 

