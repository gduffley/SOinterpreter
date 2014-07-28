/* Infix notation calculator--calc */

%{
#include "global.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>



/* prototypes */
void yyerror (char* s);
int yylex(void);
%}

/* BISON Declarations */

%start input  /* what rule starts */

%token NUM
%token STR
%token OP

%left '-' '+' /* these done for precdence */
%left '*' '/'
%right '^'   /* exponentiation        */

/* Grammar follows */
%%
input:    /* empty string */
        | input line
        ;

/* line:     '\n' */
/*        | exp '\n'  { printf ("\t%.10g\n", $1); } */

line:     '\n'               { printf(" "); }
        | exp '='            { printf("%f", $1); }
        ;

exp:      NUM                { $$ = $1;         }
        | exp '+' exp         { $$ = $1 + $3;    }
        | exp '-' exp        { $$ = $1 - $3;    }
        | exp '*' exp        { $$ = $1 * $3;    }
        | exp '/' exp        { $$ = $1 / $3;    }
        | exp '^' exp        { $$ = pow ($1, $3); }
        | '(' exp ')'        { $$ = $2;         }
;

var:     STR                 {}
        

%%

int main ()
{
  yyparse ();
}

void yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("%s\n", s);
}
