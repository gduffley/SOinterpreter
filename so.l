%{
#include <stdlib.h>
#include <string.h>
#include "so.tab.h"

void yyerror(char *);
int myAtoi(char yytext[]);
%}

%%

[ ]             {}
[a-z] {
	yylval.sIndex = *yytext;
	return VAR;
}
"plus"				return PLUS;
"minus"				return SUB; 
"divide"			return DIV; 
"multiply"			return MULT;
eq 					return EQ; 
gt					return GT;
ge					return GE;
lt					return LT;
le					return LE;
eqeq				return EE;
!eq					return NE;
while				return WHILE;
if					return IF;
print				return PRINT;
"[A-Za-z]*"			{strcpy(yylval.sval, yytext);
					return STRING;}

[ \t\n]+ 			; /* ignore whitespace */ 
[;{}.()]			return *yytext;
.               	yyerror("Unknown character");

%%

int yywrap(void)
{
  return 1;
}


