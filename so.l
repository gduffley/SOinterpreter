%{
#include "global.h"
#include "so.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
int myAtoi(char[]);
%}

%%
[ ]             {}
[0123456789]+   yylval = atoi( yytext ); return NUM;
[(zero)(one)(two)(three)(four)(five)(six)(seven)(eight)(nine)]*(point)?[(zero)(one)(two)(three)(four)(five)(six)(seven)(eight)(nine)]* yylval = myAtoi(yytext); return NUM;
.               return (int) yytext[0];
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
	//printf("String is: %s\n", numString);
	double num = atof(numString);
	//printf("Before the division: %f\n", num);
	if(digDecisAt > 0){
		num = num / pow (10, strlen(numString) - digDecisAt);
	}
	printf("Final number: %f\n", num);
	return num;
}