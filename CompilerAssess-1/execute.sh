lex lex.l
yacc -d yacc.y -o yacc.cc
gcc -c lex.yy.c -o lex.yy.o
g++ lex.yy.o yacc.cc
./a.out<inp.txt
