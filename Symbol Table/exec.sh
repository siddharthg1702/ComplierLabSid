lex symbol.l
yacc -d symbol.y -o symbol.cc
gcc -c lex.yy.c -o lex.yy.o
g++ lex.yy.o symbol.cc
clear
./a.out<inp.txt
