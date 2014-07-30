/* Infix notation calculator--calc */

%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "global.h"

/* prototypes */
void yyerror (char* s);
int yylex(void);
char* sym[26];
int myAtoi(char[]);
char* plus(char* s1, char* s2);
char* sub(char* s1, char* s2);
char* mult(char* s1, char* s2);
char* div(char* s1, char* s2);



%}


/* BISON Declarations */

%start input  /* what rule starts */

%token PRINT VAR STRING 

%left GE LE EQ NE GT LT EE 
%left PLUS SUB /* these done for precdence */
%left MULT DIV

%union{
    char *sval;
    char sIndex; 
}


%type <sval> STRING exp 
%token <sIndex> VAR 
/* Grammar follows */
%%
input:    /* empty string */
        | input line 
;

/* line:     '\n' */
/*        | exp '\n'  { printf ("\t%.10g\n", $1); } */

line:     '\n'              { printf(" "); }
        | VAR EQ exp';'     { sym[$1] = $3; }
        | PRINT exp';'      { printf("%s\n", $2);}      
        ;

exp:      STRING             { $$ = $1;             }
        | VAR                { $$  = sym[$1]        }
        | exp PLUS exp       { $$ = plus($1, $3);   }
        | exp SUB exp        { $$ = sub($1 , $3);   }
        | exp MULT exp       { $$ = mult($1, $3;    }
        | exp DIV exp        { $$ = div($1, $3;     }
        | '(' exp ')'        { $$ = $2;             }

;
%%

int main ()
{
  yyparse ();
}

void yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("%s\n", s);
}

int myAtoi(char yytext[]){
    char cur = yytext[0];
    int i = 0;
    int digDecisAt = 0;
    char numString[50];
    strcpy (numString, "");
    //printf("original string : %s\n", yytext);
    while(i < yyleng){
        cur = yytext[i];
        //printf("current char %c\n", yytext[i]);
        switch (cur){
            case 'z':
                strcat(numString, "0");
                i += 4;
                break;
            case 'o':
                strcat (numString, "1");
                i += 3;
                break;
            case 't':
                if (yytext[i + 1] == 'w'){
                    strcat (numString, "2");
                    i += 3;
                }
                else{
                    strcat (numString, "3");
                    i += 5;
                }
                break;
            case 'f':
                if( yytext[i + 1] == 'o'){
                    strcat (numString, "4");
                    i += 4;
                }
                else{
                    strcat (numString, "5");
                    i += 4;
                }
                break;
            case 's':
                if(yytext[i + 1] == 'i'){
                    strcat (numString, "6");
                    i += 3;
                }
                else{
                    strcat (numString, "7");
                    i += 5;
                }
                break;
            case 'e':
                strcat(numString, "8");
                i += 5;
                break;
            case 'n':
                strcat(numString, "9");
                i += 4;
                break;
            case 'p':
                digDecisAt = strlen(numString);
                i += 5;
                break;
        }
    }
    int num = atoi(numString);
    return atoi(numString);
}

char * plus(char* s1, char*s2){
    
}

