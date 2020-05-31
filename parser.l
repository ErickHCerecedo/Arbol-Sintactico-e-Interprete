/* Archivo con el reconocedor lexico para el scanner */
%option yylineno
%{
    #include<stdlib.h>
    #include<math.h>
    #include <string.h>
    // Se incluye el archivo generado por bison para tener las definiciones de los tokens
    #include "parser.tab.h"
%}

/* Operadores del Sistema & Palabras Reservadas del Sistema */
LTR	 [a-zA-Z]
DGT	 [0-9]
BIN  [0-1] 
SB   [$|_]
WHITESPACE [ \t\r]+ 

%%

[[:space:]]+

({DGT})({DGT})* 			    {return INT_NUMBER;                 /* Se encontro un tipo de dato entero */                    }
({DGT})*"."({DGT})({DGT})*      {return FLOAT_NUMBER;               /* Se encontro un tipo de dato float */                     }

"program"                       {return PROGRAM_TERMINAL;           /* Se encontro la palabra reservada program */              }
"set"                           {return SET_TERMINAL;               /* Se encontro la palabra reservada set */                  }
"if"							{return IF_TERMINAL;                /* Se encontro la palabra reservada if */                   }
"ifelse"                        {return IFELSE_TERMINAL;            /* Se encontro la palabra reservada ifelse */               }
"while"                         {return WHILE_TERMINAL;             /* Se encontro la palabra reservada while */                }
"for"							{return FOR_TERMINAL;               /* Se encontro la palabra reservada for */                  }
"to"							{return TO_TERMINAL;                /* Se encontro la palabra reservada to */                   }
"step"							{return STEP_TERMINAL;              /* Se encontro la palabra reservada step */                 }
"do"							{return DO_TERMINAL;                /* Se encontro la palabra reservada do */                   }
"var"                           {return VAR_TERMINAL;               /* Se encontro la palabra reservada var */                  }
"read"							{return READ_TERMINAL;              /* Se encontro la palabra reservada read */                 }
"print"							{return PRINT_TERMINAL;             /* Se encontro la palabra reservada print */                }
"int"							{yylval.type=(char*)malloc(strlen(yytext)+1); strcpy(yylval.type, yytext); return INT_TERMINAL;   /* Se encontro la palabra reservada int */    }
"float"							{yylval.type=(char*)malloc(strlen(yytext)+1); strcpy(yylval.type, yytext); return FLOAT_TERMINAL; /* Se encontro la palabra reservada float */  }

"{"							    {return LLAVE_ABRE_TERMINAL;        /* Se encontro un simbolo reservado llave abierta */        }
"}"							    {return LLAVE_CIERRA_TERMINAL;      /* Se encontro un simbolo reservado llave abierta  */       }
"("                             {return PARENTESIS_ABRE_TERMINAL;   /* Se encontro un simbolo reservado parentesis abierto */   }
")"                             {return PARENTESIS_CIERRA_TERMINAL; /* Se encontro un simbolo reservado parentesis cerrado */   }
";"                             {return PUNTO_COMA_TERMINAL;        /* Se encontro un simbolo reservado punto y coma */         }
":"                             {return DOS_PUNTOS_TERMINAL;        /* Se encontro un simbolo reservado dos puntos*/            }
"+"                             {return MAS_TERMINAL;               /* Se encontro un simbolo de Suma */                        }
"-"                             {return MENOS_TERMINAL;             /* Se encontro un simbolo de Resta */                       }
"*"                             {return POR_TERMINAL;               /* Se encontro un simbolo de Multiplicacion */              }
"/"                             {return ENTRE_TREMINAL;             /* Se encontro un simbolo de Division */                    }
"="                             {return IGUAL_TERMINAL;             /* Se encontro un simbolo de Igualacion */                  }
"<"                             {return MENORQUE_TERMINAL;          /* Se encontro un simbolo de Menor que */                   }
">"                             {return MAYORQUE_TERMINAL;          /* Se encontro un simbolo de Mayor que */                   }
"<="                            {return MENORIGUALQUE_TERMINAL;     /* Se encontro un simbolo de Menor Igual a */               }
">="                            {return MAYORIGUALQUE_TEMRINAL;     /* Se encontro un simbolo de Mayor Igual a */               }

({SB}|{LTR})({LTR}|{DGT}|{SB})* {yylval.id=(char*)malloc(strlen(yytext)+1); strcpy(yylval.id, yytext); return ID_TERMINAL; /* Se encontro la palabra reservada id */   } 

.								{return OTHER;              /* Se encontro un simbolo no identificado */                }

%%
