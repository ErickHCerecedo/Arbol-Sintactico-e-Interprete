/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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
     ID = 258,
     LCIERRA = 259,
     SPACE = 260,
     SET = 261,
     ABREPA = 262,
     CIERRAPA = 263,
     OTHER = 264,
     READ = 265,
     PRINT = 266,
     TO = 267,
     STEP = 268,
     MENORIGUALQUE = 269,
     MAYORIGUALQUE = 270,
     DOSPUNTOS = 271,
     VAR = 272,
     LABRE = 273,
     PUNTOYCOMA = 274,
     MENOS = 275,
     MENORQUE = 276,
     MAYORQUE = 277,
     IGUAL = 278,
     MAS = 279,
     IFELSE = 280,
     MULTIPLICA = 281,
     DIVIDE = 282,
     IF_CONST = 283,
     ELSE_CONST = 284,
     FOR_CONST = 285,
     INT_NUMBER = 286,
     FLOAT_NUMBER = 287,
     INT_CONST = 288,
     FLOAT_CONST = 289,
     FOREACH_CONST = 290,
     BEGIN_CONST = 291,
     END_CONST = 292,
     BOOLEAN_CONST = 293,
     VAR_CONST = 294,
     WHILE_CONST = 295,
     DO_CONST = 296,
     PROCEDURE_CONST = 297,
     PROGRAM_CONST = 298
   };
#endif
/* Tokens.  */
#define ID 258
#define LCIERRA 259
#define SPACE 260
#define SET 261
#define ABREPA 262
#define CIERRAPA 263
#define OTHER 264
#define READ 265
#define PRINT 266
#define TO 267
#define STEP 268
#define MENORIGUALQUE 269
#define MAYORIGUALQUE 270
#define DOSPUNTOS 271
#define VAR 272
#define LABRE 273
#define PUNTOYCOMA 274
#define MENOS 275
#define MENORQUE 276
#define MAYORQUE 277
#define IGUAL 278
#define MAS 279
#define IFELSE 280
#define MULTIPLICA 281
#define DIVIDE 282
#define IF_CONST 283
#define ELSE_CONST 284
#define FOR_CONST 285
#define INT_NUMBER 286
#define FLOAT_NUMBER 287
#define INT_CONST 288
#define FLOAT_CONST 289
#define FOREACH_CONST 290
#define BEGIN_CONST 291
#define END_CONST 292
#define BOOLEAN_CONST 293
#define VAR_CONST 294
#define WHILE_CONST 295
#define DO_CONST 296
#define PROCEDURE_CONST 297
#define PROGRAM_CONST 298




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 18 "parser.y"
{
  char *id;
  char *type;
}
/* Line 1529 of yacc.c.  */
#line 140 "parser.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

