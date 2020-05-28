%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
FILE extern *yyin;
char extern *yytext;
int yylineno;
int yylex();
int yyerror(char const * s);
void agregaTabla(char * var, char *tipo);
void crearTabla();
void checkVariable(char * var);
void imprimeTabla();
void checkSimbolo(char *var);

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

char symbolTable [100][50][2];

//INICIO LA TABLA
void crearTabla(){
  int i;
  for (i = 0; i < 100; i++){
    strcpy(symbolTable[i][0], "");
    strcpy(symbolTable[i][1], "");
  }
}

//CHECA SI NO ESTA EL SIMBOLO YA EN LA TABLA
void checkSimbolo(char *var){
  int i = 0;
  for (i = 0; i < 100; i++){
    if (strcmp(symbolTable[i][0], var) == 0){
      char errorMsg [255];
      sprintf(errorMsg, "La variable %s ya estaba inicializada", var);
      yyerror(errorMsg);
      exit(-1);
    }
  }
}

//CHECA SI LA VARIABLE ESTA DENTRO DE LA TABLA 
void checkVariable(char * var){
  int i;
  for (i = 0; i < 100; i++){
    if (strcmp(symbolTable[i][0], var) == 0){
      return;
    } 
  }
  char errorMsg [255];
  sprintf(errorMsg, "La variable %s no estaba inicializada", var);
  yyerror(errorMsg);
  exit(-1);
}

//INSERTA UN NUEVO SIMBOLO Y CHECA SI NO ESTA YA DECLARADO Y SI NO LO ANIADE EN LA PRIMER POSICION VACIA
void agregaTabla(char *var, char *tipo){
  checkSimbolo(var);
  int i = 0;
  for (i = 0; i < 100; i++){
    if (strcmp(symbolTable[i][0], "") == 0){
      strcpy(symbolTable[i][0], var);
      strcpy(symbolTable[i][1], tipo);
      break;    
    }
  }
}

//IMPRIME TABLA DE SIMBOLOS
void imprimeTabla(){
  printf("Tabla de simbolos: \n");
  int i; 
  for (i = 0; i < 100; i++){
    if (strcmp(symbolTable[i][0], "") != 0){
      printf("%s  %s\n", symbolTable[i][0], symbolTable[i][1]);
    }
  }
}


//IMPRIME ERROR
int yyerror(char const * s){
 fprintf(stderr, "%s en la linea: %d \n", s, yylineno);
 return 1;
}
 


//MAIN 
int main(int argc, char *argv[]) {
    crearTabla();
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
}

