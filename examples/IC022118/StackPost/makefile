
go: lex.yy.c stpost.tab.c 
	gcc stpost.tab.c lex.yy.c -lfl -ly -o go 

lex.yy.c: stpost.l
	flex stpost.l

stpost.tab.c: stpost.y
	bison -dv stpost.y

clean:
	rm -f lex.yy.c 
	rm -f stpost.output
	rm -f stpost.tab.h
	rm -f stpost.tab.c
	rm -f go

