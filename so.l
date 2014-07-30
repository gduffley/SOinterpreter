%{
#include <stdlib.h>
#include <string.h>
void yyerror(char *);
int myAtoi(char yytext[]);
%}

%%

[ ]             {}
[a-z] {
	yylval.sIndex = strdup(yytext + 1);
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
else				return ELSE;
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
