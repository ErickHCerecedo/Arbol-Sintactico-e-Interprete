/*
  Este archivo contiene un reconocedor de expresiones aritmeticas junto
  con algunas reglas semanticas forman parte de la gramatica proporcionada
  por el profesor, contine tambien una tabla de simbolos general,
  Contiene la implementacion de un arbol sintactico y el interprete requerido.

  Autores:
      Erick de Jesus Hernandez Cerecedo A01066428
      Everardo Becerril                 A013

*/

%{
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>
  #include<math.h>
  #include <stdbool.h>
  FILE extern *yyin;                          // Apuntador a archivo de texto
  char extern *yytext;                        // Variable de texto (Empleadas por bisont)
  int yylineno;                               // Variable de linea (Empleadas por bisont)
  int yylex();                                
  int yyerror(char const * s);                // Funcion que imprime errores
  void init();                                // Funcion que inicia la tabla de simbolos
  void imprimeTabla();                        // Muestra el mensaje de programa aceptado
  void agregaTabla(char * var, char *tipo);   // Funcion que agrega una variable a la tabla de simbolos
  void checkVariable(char * var);             // Funcion que revisa si una variable fue inicializada
  bool checkSimbolo(char *var);               // Funcion que verifica si una variable ya existe en la tabla
%}
%union{
  char *id;
  char *type;
}

%token <id > ID 
%type <type > tipo INT_CONST FLOAT_CONST

%token LCIERRA SPACE SET ABREPA CIERRAPA OTHER READ PRINT TO STEP MENORIGUALQUE MAYORIGUALQUE DOSPUNTOS VAR LABRE PUNTOYCOMA MENOS
MENORQUE MAYORQUE IGUAL MAS IFELSE MULTIPLICA DIVIDE  IF_CONST  ELSE_CONST  FOR_CONST INT_NUMBER FLOAT_NUMBER INT_CONST FLOAT_CONST
FOREACH_CONST  BEGIN_CONST  END_CONST  BOOLEAN_CONST  VAR_CONST  WHILE_CONST  DO_CONST  PROCEDURE_CONST  PROGRAM_CONST  
%start prog


%%
 
 prog: PROGRAM_CONST ID LABRE opt_decls LCIERRA stmt {printf("¡Programa valido! \n\n"); imprimeTabla(); return 0;} 

 opt_decls  : decls
            | /* epsilon */
            ;

decls   : dec PUNTOYCOMA decls 
        | dec
        ;

dec : VAR ID DOSPUNTOS tipo { agregaTabla($2, $4);}
;

tipo : INT_CONST 
     | FLOAT_CONST 
     ;

stmt    : assign_stmt
        | if_stmt
        | iter_stmt
        | cmp_stmt
        ;

assign_stmt : SET ID expr PUNTOYCOMA {checkVariable($2);}
            | READ ID PUNTOYCOMA {checkVariable($2);}
            | PRINT expr PUNTOYCOMA
            ;

if_stmt : IF_CONST ABREPA expresion CIERRAPA stmt
        | IFELSE ABREPA expresion CIERRAPA stmt stmt 
        ;

iter_stmt   : WHILE_CONST ABREPA expresion CIERRAPA stmt
            | FOR_CONST SET ID expr TO expr STEP expr DO_CONST stmt {checkVariable($3);}
            ;

cmp_stmt    : LABRE LCIERRA
            | LABRE stmt_lst LCIERRA
            ;

stmt_lst    : stmt  
            | stmt_lst stmt
            ;

expr    : expr MAS term
        | expr MENOS term
        | term
        ;

term    : term MULTIPLICA factor
        |term DIVIDE factor
        | factor
        ;

factor  : ABREPA expr CIERRAPA
        | ID {checkVariable($1);}
        | INT_NUMBER
        | FLOAT_NUMBER
        ;

expresion   : expr MENORQUE expr
            | expr MAYORQUE expr
            | expr IGUAL expr
            | expr MENORIGUALQUE expr
            | expr MAYORIGUALQUE expr
            ;

%%

// Tabla de Simbolos
char symbolTable [100][50][2];

// Funcion que inicia la tabla de simbolos
void init(){
  for (int i = 0; i < 100; i++){
    strcpy(symbolTable[i][0], "");
    strcpy(symbolTable[i][1], "");
  }
}

// Funcion que verifica si una variable ya existe en la tabla
bool checkSimbolo(char *var){
  bool resultado = false;
  for (int i = 0; i < 100; i++){
    if (strcmp(symbolTable[i][0], var) == 0){
      resultado = true;
      break;
    }
  }
  return resultado;
}

// Funcion que revisa si una variable fue inicializada
void checkVariable(char * var){
  if (buscaSimbolo(var) == false){
    char errorMsg [255];
    sprintf(errorMsg, "La variable %s no fue inicializada", var);
    yyerror(errorMsg);
    //exit(-1);
  }
}

// Funcion que agrega una variable a la tabla de simbolos si y solo si, este no fue declarado antes
void agregaTabla(char *var, char *tipo){
  if (buscaSimbolo(var)){
    char errorMsg [255];
    sprintf(errorMsg, "La variable %s ya fue declarada", var);
    yyerror(errorMsg);
    //exit(-1);
  }
  else{
    for (int i = 0; i < 100; i++){
      if (strcmp(symbolTable[i][0], "") == 0){
        strcpy(symbolTable[i][0], var);
        strcpy(symbolTable[i][1], tipo);
        break;    
      }
    }
  } 
}

// Muestra el resultado de un programa aceptado
void imprimeTabla(){
  printf("...Programa aceptado...\n");
  printf("\n+---------------------------\n");
  printf("| Tabla de Simbolos \n"); 
  printf("+---------------------------\n");
  for (int i = 0; i < 100; i++){
    if (strcmp(symbolTable[i][0], "") != 0){
      printf("| %d.-  %s : %s\n", i, symbolTable[i][0], symbolTable[i][1]);
      printf("+---------------------------\n");
    }
  }
}


// Funcion que muestra los errores
int yyerror(char const * s){
  fprintf(stderr, "%s: ver linea << %d >> simbolo << %s >>\n", s, yylineno, yytext)
  return 1;
}

// Funcion Main 
int main(int argc, char *argv[]) {
  init();
  if(argc == 1)
    printf("No fue encontrado el archivo del programa especificado.\n");
  else{
    yyin = fopen(argv[1], "r");
    yyparse();
  }
  fclose(yyin);
}

