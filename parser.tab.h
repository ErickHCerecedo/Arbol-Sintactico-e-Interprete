
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID_TERMINAL = 258,
     FLOAT_NUMBER = 259,
     INT_NUMBER = 260,
     PROGRAM_TERMINAL = 261,
     SET_TERMINAL = 262,
     IF_TERMINAL = 263,
     IFELSE_TERMINAL = 264,
     WHILE_TERMINAL = 265,
     FOR_TERMINAL = 266,
     TO_TERMINAL = 267,
     STEP_TERMINAL = 268,
     DO_TERMINAL = 269,
     VAR_TERMINAL = 270,
     READ_TERMINAL = 271,
     PRINT_TERMINAL = 272,
     INT_TERMINAL = 273,
     FLOAT_TERMINAL = 274,
     LLAVE_ABRE_TERMINAL = 275,
     LLAVE_CIERRA_TERMINAL = 276,
     PARENTESIS_ABRE_TERMINAL = 277,
     PARENTESIS_CIERRA_TERMINAL = 278,
     PUNTO_COMA_TERMINAL = 279,
     DOS_PUNTOS_TERMINAL = 280,
     MAS_TERMINAL = 281,
     MENOS_TERMINAL = 282,
     POR_TERMINAL = 283,
     ENTRE_TREMINAL = 284,
     IGUAL_TERMINAL = 285,
     MENORQUE_TERMINAL = 286,
     MAYORQUE_TERMINAL = 287,
     MENORIGUALQUE_TERMINAL = 288,
     MAYORIGUALQUE_TEMRINAL = 289,
     OTHER = 290
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 37 "parser.y"

  char *id;
  char *type;



/* Line 1676 of yacc.c  */
#line 94 "parser.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


