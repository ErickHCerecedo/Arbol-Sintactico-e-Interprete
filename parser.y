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
    #include<stdbool.h>
    FILE extern *yyin;                          // Apuntador a archivo de texto
    char extern *yytext;                        // Variable de texto (Empleadas por bisont)
    extern int yylineno;                        // Variable de linea (Empleadas por bisont)
    int yylex();                                
    int yyerror(char const * s);                // Funcion que imprime errores
    void init();                                // Funcion que inicia la tabla de simbolos
    void imprimeTabla();                        // Muestra el mensaje de programa aceptado
    void agregaTabla(char * var, char *tipo);   // Funcion que agrega una variable a la tabla de simbolos
    void checkVariable(char * var);             // Funcion que revisa si una variable fue inicializada
    bool checkSimbolo(char *var);               // Funcion que verifica si una variable ya existe en la tabla
%}

/* 
    Los elementos terminales de la gramatica. La declaracion de abajo se
    convierte en definicion de constantes en el archivo scanner.tab.h
    que hay que incluir en el archivo de flex. 
*/

%union{
  char *id;
  char *type;
}

%token <id > ID_TERMINAL 
%type <type > tipo INT_TERMINAL FLOAT_TERMINAL
%token  FLOAT_NUMBER INT_NUMBER PROGRAM_TERMINAL SET_TERMINAL IF_TERMINAL IFELSE_TERMINAL WHILE_TERMINAL FOR_TERMINAL
        TO_TERMINAL STEP_TERMINAL DO_TERMINAL VAR_TERMINAL READ_TERMINAL PRINT_TERMINAL INT_TERMINAL FLOAT_TERMINAL
        LLAVE_ABRE_TERMINAL LLAVE_CIERRA_TERMINAL PARENTESIS_ABRE_TERMINAL PARENTESIS_CIERRA_TERMINAL PUNTO_COMA_TERMINAL
        DOS_PUNTOS_TERMINAL MAS_TERMINAL MENOS_TERMINAL POR_TERMINAL ENTRE_TREMINAL IGUAL_TERMINAL MENORQUE_TERMINAL
        MAYORQUE_TERMINAL MENORIGUALQUE_TERMINAL MAYORIGUALQUE_TEMRINAL OTHER
%start prog

/* 
    Las reglas de la gramatica.
*/

%%

prog:           PROGRAM_TERMINAL ID_TERMINAL LLAVE_ABRE_TERMINAL opt_decls LLAVE_CIERRA_TERMINAL stmt  {imprimeTabla(); return 0;} 
;

opt_decls:      decls
            |   /* epsilon */
;

decls:          dec PUNTO_COMA_TERMINAL decls 
            |   dec
;

dec:            VAR_TERMINAL ID_TERMINAL DOS_PUNTOS_TERMINAL tipo   {agregaTabla($2, $4);}
;

tipo:           INT_TERMINAL 
            |   FLOAT_TERMINAL 
;

stmt:           assign_stmt
            |   if_stmt
            |   iter_stmt
            |   cmp_stmt
;

assign_stmt:    SET_TERMINAL ID_TERMINAL expr PUNTO_COMA_TERMINAL {checkVariable($2);}
            |   READ_TERMINAL ID_TERMINAL PUNTO_COMA_TERMINAL {checkVariable($2);}
            |   PRINT_TERMINAL expr PUNTO_COMA_TERMINAL
;

if_stmt:        IF_TERMINAL PARENTESIS_ABRE_TERMINAL expresion PARENTESIS_CIERRA_TERMINAL stmt
            |   IFELSE_TERMINAL PARENTESIS_ABRE_TERMINAL expresion PARENTESIS_CIERRA_TERMINAL stmt stmt 
;

iter_stmt:      WHILE_TERMINAL PARENTESIS_ABRE_TERMINAL expresion PARENTESIS_CIERRA_TERMINAL stmt
            |   FOR_TERMINAL SET_TERMINAL ID_TERMINAL expr TO_TERMINAL expr STEP_TERMINAL expr DO_TERMINAL stmt {checkVariable($3);}
;

cmp_stmt:       LLAVE_ABRE_TERMINAL LLAVE_CIERRA_TERMINAL
            |   LLAVE_ABRE_TERMINAL stmt_lst LLAVE_CIERRA_TERMINAL
;

stmt_lst:       stmt  
            |   stmt_lst stmt
;

expr:           expr MAS_TERMINAL term
            |   expr MENOS_TERMINAL term
            |   term
;

term:           term POR_TERMINAL factor
            |   term ENTRE_TREMINAL factor
            |   factor
;

factor:         PARENTESIS_ABRE_TERMINAL expr PARENTESIS_CIERRA_TERMINAL
            |   ID_TERMINAL {checkVariable($1);}
            |   INT_NUMBER
            |   FLOAT_NUMBER
;

expresion:      expr MENORQUE_TERMINAL expr
            |   expr MAYORQUE_TERMINAL expr
            |   expr IGUAL_TERMINAL expr
            |   expr MENORIGUALQUE_TERMINAL expr
            |   expr MAYORIGUALQUE_TEMRINAL expr
;

%%

// Tabla de Simbolos
char symbolTable [100][50][2];
bool error = false;
// Funcion que inicia la tabla de simbolos
void init(){
  for (int i = 0; i < 100; i++){
    strcpy(symbolTable[i][0], "");
    strcpy(symbolTable[i][1], "");
  }
  
}

// Funcion que verifica si una variable ya existe en la tabla
bool checkSimbolo(char * var){
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
  if (checkSimbolo(var) == false){
    char errorMsg [255];
    sprintf(errorMsg, "La variable %s no fue inicializada", var);
    yyerror(errorMsg);
    //exit(-1);
  }
}

// Funcion que agrega una variable a la tabla de simbolos si y solo si, este no fue declarado antes
void agregaTabla(char *var, char *tipo) {
  if (checkSimbolo(var)){
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
void imprimeTabla() {
    if(error){
        printf("...Resuelva los errores marcados en el sistema...\n");
    }
    else{
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
}

// Funcion que muestra los errores
int yyerror(char const * s) {
    fprintf(stderr, "%s: ver linea << %d >> simbolo << %s >>\n", s, yylineno, yytext);
    error = true;
}

// Funcion Main 
void main(int argc, char *argv[]) {
    init();  
    if (argc == 1)
        printf("No fue encontrado el archivo del programa especificado.\n");
    else{
        yyin = fopen(argv[1], "r");
        yyparse();
    } 
    fclose(yyin);
}