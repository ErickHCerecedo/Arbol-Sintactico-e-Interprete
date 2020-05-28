Para compilar correr los siguientes comandos
flex parser.lex
bison -d parser.y
gcc lex.yy.c parser.tab.c -lfl
./a.out < prueba1.txt
