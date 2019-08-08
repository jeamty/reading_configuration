CC := gcc
RM := rm -rf

config : main.o config.bison.tab.o config.lex.yy.o
	$(CC) -o $@ $^

config.bison.tab.o : config.bison.tab.c config.bison.tab.h config.h
	$(CC) -o $@ -c config.bison.tab.c

config.lex.yy.o : config.lex.yy.c config.bison.tab.h 
	$(CC) -o $@ -c config.lex.yy.c 

config.bison.tab.c : config.y 
	bison -d -o $@ $^

config.lex.yy.c : config.l
	flex -o $@ $^

main.o : main.c config.h config.bison.tab.c 
	$(CC) -o $@ -c main.c

.PHONY: clean

clean :
	-$(RM) config main.o config.bison.tab.o config.lex.yy.o config.bison.tab.c config.lex.yy.c config.bison.tab.h
