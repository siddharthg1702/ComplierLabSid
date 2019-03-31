lex dag.l
yacc -d dag.y -o dag.cc
gcc -c lex.yy.c -o lex.yy.o
g++ lex.yy.o dag.cc
./a.out<inp.txt
