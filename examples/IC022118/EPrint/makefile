
go: lex.yy.c exp.tab.c 
	gcc exp.tab.c lex.yy.c -lfl -ly -o go 

lex.yy.c: exp.l
	flex exp.l

exp.tab.c: exp.y
	bison -dv exp.y

clean:
	rm -f lex.yy.c 
	rm -f exp.output
	rm -f exp.tab.h
	rm -f exp.tab.c
	rm -f go

