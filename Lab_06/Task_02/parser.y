%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(const char *s);

int tempCount = 1;
char buf[10];

char* newTemp() {
    sprintf(buf, "t%d", tempCount++);
    return strdup(buf);
}
%}

%union {
    char* str;
}

%token <str> ID NUM
%token SQRT POW LOG EXP SIN COS TAN ABS
%token NEWLINE

%type <str> Expression Term Factor FunctionCall

%%

Program:
      Program Statement
    | Statement
    ;

Statement:
      ID '=' Expression NEWLINE
        {
            printf("%s = %s\n", $1, $3);
        }
    ;

Expression:
      Expression '+' Term
        {
            char* t = newTemp();
            printf("%s = %s + %s\n", t, $1, $3);
            $$ = t;
        }
    | Expression '-' Term
        {
            char* t = newTemp();
            printf("%s = %s - %s\n", t, $1, $3);
            $$ = t;
        }
    | Term
        {
            $$ = $1;
        }
    ;

Term:
      Term '*' Factor
        {
            char* t = newTemp();
            printf("%s = %s * %s\n", t, $1, $3);
            $$ = t;
        }
    | Term '/' Factor
        {
            char* t = newTemp();
            printf("%s = %s / %s\n", t, $1, $3);
            $$ = t;
        }
    | Term '%' Factor
        {
            char* t = newTemp();
            printf("%s = %s %% %s\n", t, $1, $3);
            $$ = t;
        }
    | Factor
        {
            $$ = $1;
        }
    ;

Factor:
      '-' Factor
        {
            char* t = newTemp();
            printf("%s = - %s\n", t, $2);
            $$ = t;
        }
    | '(' Expression ')'
        {
            $$ = $2;
        }
    | FunctionCall
        {
            $$ = $1;
        }
    | ID
        {
            $$ = $1;
        }
    | NUM
        {
            $$ = $1;
        }
    ;

FunctionCall:
      SQRT '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = sqrt ( %s )\n", t, $3);
            $$ = t;
        }
    | LOG '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = log ( %s )\n", t, $3);
            $$ = t;
        }
    | EXP '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = exp ( %s )\n", t, $3);
            $$ = t;
        }
    | SIN '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = sin ( %s )\n", t, $3);
            $$ = t;
        }
    | COS '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = cos ( %s )\n", t, $3);
            $$ = t;
        }
    | TAN '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = tan ( %s )\n", t, $3);
            $$ = t;
        }
    | ABS '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = abs ( %s )\n", t, $3);
            $$ = t;
        }
    | POW '(' Expression ',' Expression ')'
        {
            char* t = newTemp();
            printf("%s = pow ( %s , %s )\n", t, $3, $5);
            $$ = t;
        }
    ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Syntax error\n");
    return 0;
}
