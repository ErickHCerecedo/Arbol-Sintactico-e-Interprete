/* Archivo con el reconocedor lexico para el scanner */
%{
#include<stdlib.h>
#include<math.h>
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
WHITESPACE  { }
"\n"    {yylineno++;}
"program"                       {return PROGRAM_CONST;      /* Se encontro la palabra reservada program */     }
"float"							{yylval.type=(char*)malloc(strlen(yytext)+1); strcpy(yylval.type, yytext); return FLOAT_CONST;      /* Se encontro la palabra reservada FLOAT CONSTANT */  }
"int"							{yylval.type=(char*)malloc(strlen(yytext)+1); strcpy(yylval.type, yytext); return INT_CONST;        /* Se encontro la palabra reservada INT CONSTANT */    }
"print"							{return PRINT;              /* Se encontro la palabra reservada print */       }
"to"							{return TO;                 /* Se encontro la palabra reservada to */          }
"if"							{return IF_CONST;           /* Se encontro la palabra reservada if */          }
"read"							{return READ;               /* Se encontro la palabra reservada read */        }
"set"                           {return SET;                /* Se encontro la palabra reservada set */         }
"var"                           {return VAR;                /* Se encontro la palabra reservada var */         }
"ifelse"                        {return IFELSE;             /* Se encontro la palabra reservada ifelse */      }
"else"							{return ELSE_CONST;         /* Se encontro la palabra reservada else */        }
"for"							{return FOR_CONST;          /* Se encontro la palabra reservada for */         }
"foreach"						{return FOREACH_CONST;      /* No hay que usar foreach -------------*/         }
"begin"							{return BEGIN_CONST;        /* -------------------------------------*/         }
"end"							{return END_CONST;          /* -------------------------------------*/         }
"boolean"						{return BOOLEAN_CONST;      /* -------------------------------------*/         }
"while"							{return WHILE_CONST;        /* Se encontro la palabra reservada while */       }
"do"							{return DO_CONST;           /* Se encontro la palabra reservada do */          }
"step"							{return STEP;               /* Se encontro la palabra reservada step */        }
"procedure"						{return PROCEDURE_CONST;    /* -------------------------------------*/          }
({DGT})*"."({DGT})({DGT})*      {return FLOAT_NUMBER;       /* Se encontro un tipo de dato float */            }
({DGT})({DGT})* 			    {return INT_NUMBER;         /* Se encontro un tipo de dato entero */           }
"{"							    {return LABRE;              /* Se encontro un simbolo reservado llave abierta */        }
"}"							    {return LCIERRA;            /* Se encontro un simbolo reservado llave abierta  */       }
"("                             {return ABREPA;             /* Se encontro un simbolo reservado parentesis abierto */   }
")"                             {return CIERRAPA;           /* Se encontro un simbolo reservado parentesis cerrado */   }
";"                             {return PUNTOYCOMA;         /* Se encontro un simbolo reservado punto y coma */         }
"+"                             {return MAS;                /* Se encontro un simbolo de Suma */               }
"-"                             {return MENOS;              /* Se encontro un simbolo de Resta */              }
"*"                             {return MULTIPLICA;         /* Se encontro un simbolo de Multiplicacion */     }
"/"                             {return DIVIDE;             /* Se encontro un simbolo de Division */           }
"<"                             {return MENORQUE;           /* Se encontro un simbolo de Menor que */          }
">"                             {return MAYORQUE;           /* Se encontro un simbolo de Mayor que */          }
"<="                            {return MENORIGUALQUE;      /* Se encontro un simbolo de Menor Igual a */      }
">="                            {return MAYORIGUALQUE;      /* Se encontro un simbolo de Mayor Igual a */}
":"                             {return DOSPUNTOS;          /* Se encontro un simbolo reservado dos puntos*/   }
"="                             {return IGUAL;              /* Se encontro un simbolo de Igualacion */         }
({SB}|{LTR})({LTR}|{DGT}|{SB})* {yylval.id=(char*)malloc(strlen(yytext)+1); strcpy(yylval.id, yytext); return ID;} 

.								{return OTHER;              /* Se encontro un simbolo no identificado */       }



%%
