%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

int tempCount = 1;
char temp[10];

char* newTemp() {
    sprintf(temp, "t%d", tempCount++);
    return strdup(temp);
}

void emit(char *s) {
    printf("%s\n", s);
}
%}

%union { char* str; }

%token <str> ID NUM
%token NOT OR AND POW IDIV MOD GT LT

%left OR
%left AND
%left GT LT
%left '+' '-'
%left '*' '/' MOD IDIV
%right POW
%right NOT

%type <str> expr stmt

%%
program
    : program stmt
    | stmt
    ;

stmt
    : ID '=' expr {
          printf("%s = %s\n", $1, $3);
      }
    ;

expr
    : expr '+' expr {
          char *t = newTemp();
          printf("%s = %s + %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '-' expr {
          char *t = newTemp();
          printf("%s = %s - %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '*' expr {
          char *t = newTemp();
          printf("%s = %s * %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '/' expr {
          char *t = newTemp();
          printf("%s = %s / %s\n", t, $1, $3);
          $$ = t;
      }
    | expr MOD expr {
          char *t = newTemp();
          printf("%s = %s %% %s\n", t, $1, $3);
          $$ = t;
      }
    | expr IDIV expr {
          char *t = newTemp();
          printf("%s = %s // %s\n", t, $1, $3);
          $$ = t;
      }
    | expr POW expr {
          char *t = newTemp();
          printf("%s = %s ** %s\n", t, $1, $3);
          $$ = t;
      }
    | expr GT expr {
          char *t = newTemp();
          printf("%s = %s > %s\n", t, $1, $3);
          $$ = t;
      }
    | expr LT expr {
          char *t = newTemp();
          printf("%s = %s < %s\n", t, $1, $3);
          $$ = t;
      }
    | expr AND expr {
          char *t = newTemp();
          printf("%s = %s && %s\n", t, $1, $3);
          $$ = t;
      }
    | expr OR expr {
          char *t = newTemp();
          printf("%s = %s || %s\n", t, $1, $3);
          $$ = t;
      }
    | NOT expr {
          char *t = newTemp();
          printf("%s = ! %s\n", t, $2);
          $$ = t;
      }
    | '(' expr ')' { $$ = $2; }
    | ID           { $$ = $1; }
    | NUM          { $$ = $1; }
    ;
%%

void yyerror(const char *s) {
    printf("Syntax error\n");
}
