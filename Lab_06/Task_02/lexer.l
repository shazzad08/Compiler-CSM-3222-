%{
#include "parser.tab.h"
#include <string.h>
%}

%%
[ \t]+            ;
"\n"              return NEWLINE;

"sqrt"            return SQRT;
"pow"             return POW;
"log"             return LOG;
"exp"             return EXP;
"sin"             return SIN;
"cos"             return COS;
"tan"             return TAN;
"abs"             return ABS;

[0-9]+            { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }

"+"               return '+';
"-"               return '-';
"*"               return '*';
"/"               return '/';
"%"               return '%';
"="               return '=';
","               return ',';
"("               return '(';
")"               return ')';

.                 ;
%%
int yywrap() { return 1; }
