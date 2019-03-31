lex lex.l 
yacc -d yacc.y -o lex.cc
gcc -c lex.yy.c -o lex.yy.o
g++ lex.yy.o lex.cc
./a.out<inp.txt
