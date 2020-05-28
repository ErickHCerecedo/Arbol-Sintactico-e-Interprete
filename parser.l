%{
#include<stdlib.h>
#include<math.h>
#include "parser.tab.h"
%}

LTR	 [a-zA-Z]
DGT	 [0-9]
BIN  [0-1] 
SB   [$|_]
WHITESPACE [ \t\r]+ 

%%
WHITESPACE  { }
"\n"    {yylineno++;}
"program"                       {return PROGRAM_CONST;}
"float"							{yylval.type=(char*)malloc(strlen(yytext)+1); strcpy(yylval.type, yytext); return FLOAT_CONST;}
"int"							{yylval.type=(char*)malloc(strlen(yytext)+1); strcpy(yylval.type, yytext); return INT_CONST;}
"print"							{return PRINT;}
"to"							{return TO;}
"if"							{return IF_CONST;}
"read"							{return READ;}
"set"                           {return SET;}
"var"                           {return VAR;}
"ifelse"                        {return IFELSE;}
"else"							{return ELSE_CONST;}
"for"							{return FOR_CONST;}
"foreach"						{return FOREACH_CONST;}
"begin"							{return BEGIN_CONST;}
"end"							{return END_CONST;}
"boolean"						{return BOOLEAN_CONST;}
"while"							{return WHILE_CONST;}
"do"							{return DO_CONST;}
"step"							{return STEP;}
"procedure"						{return PROCEDURE_CONST;}
({DGT})*"."({DGT})({DGT})*      {return FLOAT_NUMBER;}
({DGT})({DGT})* 			    {return INT_NUMBER;}
"{"							    {return LABRE;}
"}"							    {return LCIERRA;}
"("                             {return ABREPA;}
")"                             {return CIERRAPA;}
";"                             {return PUNTOYCOMA;}
"+"                             {return MAS;}
"-"                             {return MENOS;}
"*"                             {return MULTIPLICA;}
"/"                             {return DIVIDE;}
"<"                             {return MENORQUE;}
">"                             {return MAYORQUE;}
"<="                            {return MENORIGUALQUE;}
">="                            {return MAYORIGUALQUE;}
":"                             {return DOSPUNTOS;}
"="                             {return IGUAL;}
({SB}|{LTR})({LTR}|{DGT}|{SB})* {yylval.id=(char*)malloc(strlen(yytext)+1); strcpy(yylval.id, yytext); return ID;} 

.								{ }



%%
