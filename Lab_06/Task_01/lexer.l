%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
[ \t\r]+           ;
\n                ;
"//"              return IDIV;
"**"              return POW;
"&&"              return AND;
"||"              return OR;
"!"               return NOT;
">"               return GT;
"<"               return LT;
"%"               return MOD;
"+"               return '+';
"-"               return '-';
"*"               return '*';
"/"               return '/';
"="               return '=';
"("               return '(';
")"               return ')';

[0-9]+             {
                     yylval.str = strdup(yytext);
                     return NUM;
                   }

[a-zA-Z_][a-zA-Z0-9_]* {
                     yylval.str = strdup(yytext);
                     return ID;
                   }

.                 { printf("Invalid character: %s\n", yytext); }
%%

int yywrap() { return 1; }
