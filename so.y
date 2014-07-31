/* Infix notation calculator--calc */

%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "global.h"
#include <regex.h>
#include <string.h>

/* prototypes */
void yyerror (char* s);
int yylex(void);
char* sym[26];
int myAtoi(char[]);
char* plus(char* s1, char* s2);
char* sub(char* s1, char* s2);
char* mult(char* s1, char* s2);
char* divi(char* s1, char* s2);
int matchesNum(char* s, char* num, int i);
int isNum(char* s);
char* toString(int n, char* numStr);
int strRemoveAll(char *src,char *key);

#define true 1
#define false 0


%}


/* BISON Declarations */

%start input  /* what rule starts */

%token PRINT STRING WHILE IF 

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

exp:      STRING             { $$ = $1; }             
        | VAR                { $$  = sym[$1]        }
        | exp PLUS exp       { $$ = plus($1, $3);   }
        | exp SUB exp        { $$ = sub($1 , $3);   }
        | exp MULT exp       { $$ = mult($1, $3);    }
        | exp DIV exp        { $$ = divi($1, $3);     }
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


char* plus(char* s1, char* s2){
    //printf("s1 : |%s|, s2: |%s|\n", s1, s2);
    if(isNum(s1) && isNum(s2)){
        int s1num = myAtoi(s1);
        int s2num = myAtoi(s2);
        //printf("s1: %i, s2: %i\n", s1num, s2num);
        int sum = s1num + s2num;
        //printf("sum: %i\n", sum);
        char* numStr = (char*) malloc(sizeof(char) *100);
        toString(sum, numStr);
        return numStr;
    }
    return strcat(s1, s2); 

}

char* sub(char* s1, char* s2){
    if(isNum(s1) && isNum(s2)){
        int s1num = myAtoi(s1);
        int s2num = myAtoi(s2);
        int dif = s1num - s2num;
        char* numStr = (char*) malloc(sizeof(char) *100);
        toString(dif, numStr);
        return numStr;
    }
    /*char* ptr = (char*) malloc(sizeof(char) * (strlen(s1) + 1)); 
    while( (ptr = strstr(s1, s2)) != NULL){
        char* h1 = (char*) malloc(sizeof(char) * (strlen(s1) + 1));
        char* h2 = (char*) malloc(sizeof(char) * (strlen(s1) + 1));
        strcpy(h2, (ptr + strlen(s2)));
        memmove(h1, s1, s1 - ptr);
        printf("h1: %s\n", h1);
        printf("h2: %s\n", h2);
        int i = 0;
        printf("s1: %s\n", s1);
    }*/
    while( strRemoveAll(s1, s2));
    return s1;
}

char* divi(char* s1, char* s2){
    return s1;
}

char* mult(char* s1, char* s2){
    return s1;
}

int isNum(char* s){
    if(strlen(s) == 1) return false;
    char cur = s[0];
    int i = 0;
    int digDecisAt = 0;
    char numString[50];
    strcpy (numString, "");
    //printf("original string : %s\n", yytext);
    while(i < strlen(s)){
        cur = s[i];
        //printf("current char %c\n", yytext[i]);
        switch (cur){
            case 'z':
                if(! matchesNum(s, "zero", i)) return false;
                i += 4; 
                break;
            case 'o':
                if(! matchesNum(s, "one", i)) return false; 
                i += 3;
                break;
            case 't':
                if (matchesNum(s, "two", i)){
                    i+= 3;
                    break;
                } 
                if (matchesNum(s, "three", i)){
                    i+= 5;
                    break;
                }
                return false;
            case 'f':
                if(! (matchesNum(s, "four", i) || matchesNum(s, "five", i))) return false;
                i += 4;
                break;
            case 's':
                if(matchesNum(s, "six", i)){
                    i += 3;
                    break;
                }
                if(matchesNum(s, "seven", i)){
                    i += 5;
                    break;
                }
                return false;
            case 'e':
                if(! matchesNum(s, "eight", i)) return false;
                i += 5;
                break;
            case 'n':
                if(! matchesNum(s, "nine", i)) return false;
                i += 4;
                break;
            default:
                return false;
        }
    }
    return true;
}

int matchesNum(char* s, char* num, int i){
    for(int j = 0; j < strlen(num); j++){
        if(!((i + j) < strlen(s) && s[i + j] == num[j])) return false;
    }
    return true; 
}

char* toString(int n, char* numStr){
    char str[100];
    sprintf(str, "%d", n);
    //printf("%s = str\n", str);
    strcpy(numStr, "");
    for(int i = 0; i < strlen(str); i++){
        char cur = str[i];
        switch(cur){
            case '0':
                strcat(numStr, "zero");
                break;
            case '1':
                strcat(numStr, "one");
                break;
            case '2':
                strcat(numStr, "two");
                break;
            case '3':
                strcat(numStr, "three");
                break;
            case '4':
                strcat(numStr, "four");
                break;
            case '5':
                strcat(numStr, "five");
                break;
            case '6':
                strcat(numStr, "six");
                break;
            case '7':
                strcat(numStr, "seven");
                break;
            case '8':
                strcat(numStr, "eight");
                break;
            case '9':
                strcat(numStr, "nine");
                break;
        }
    }
    return numStr;
}

int myAtoi(char* s){
    char cur = s[0];
    int i = 0;
    char numString[50];
    strcpy (numString, "");
    //printf("original string : %s\n", yytext);
    while(i < strlen(s)){
        cur = s[i];
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
                if (s[i + 1] == 'w'){
                    strcat (numString, "2");
                    i += 3;
                }
                else{
                    strcat (numString, "3");
                    i += 5;
                }
                break;
            case 'f':
                if( s[i + 1] == 'o'){
                    strcat (numString, "4");
                    i += 4;
                }
                else{
                    strcat (numString, "5");
                    i += 4;
                }
                break;
            case 's':
                if(s[i + 1] == 'i'){
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
        }
    }
    int num = atoi(numString);
    return atoi(numString);
}
int strRemoveAll(char *src,char *key)
{
  while( *src )
  {
    char *k=key,*s=src;
    while( *k && *k==*s ) ++k,++s;
    if( !*k )
    {
      while( *s ) *src++=*s++;
      *src=0;
      return 1;
    }
    ++src;
  }
  return 0;
}

