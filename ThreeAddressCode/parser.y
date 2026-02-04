%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern FILE* yyin;
int yyerror(const char *s);

int temp_index = 1;

char* createTemp() {
    char* temp = (char*)malloc(10);
    sprintf(temp, "t%d", temp_index++);
    return temp;
}
%}

%union {
    char* str;
}

%token <str> ID NUM
%token VAR
%token ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN POW_ASSIGN IDIV_ASSIGN
%token PLUS MINUS MUL DIV MOD POW IDIV ASSIGN
%token NOT OR AND GT LT
%token LPAREN RPAREN
%token NEWLINE

%type <str> expr term factor unary primary

%left OR
%left AND
%left GT LT
%left PLUS MINUS
%left MUL DIV MOD IDIV
%right POW
%right NOT

%%

program:
      program stmt
    | stmt
    ;

stmt:
      VAR ID ASSIGN expr NEWLINE {
          printf("%s = %s\n", $2, $4);
      }
    | ID ASSIGN expr NEWLINE {
          printf("%s = %s\n", $1, $3);
      }
    | ID ADD_ASSIGN expr NEWLINE {
          char* temp = createTemp();
          printf("%s = %s + %s\n", temp, $1, $3);
          printf("%s = %s\n", $1, temp);
      }
    | ID SUB_ASSIGN expr NEWLINE {
          char* temp = createTemp();
          printf("%s = %s - %s\n", temp, $1, $3);
          printf("%s = %s\n", $1, temp);
      }
    | ID MUL_ASSIGN expr NEWLINE {
          char* temp = createTemp();
          printf("%s = %s * %s\n", temp, $1, $3);
          printf("%s = %s\n", $1, temp);
      }
    | ID DIV_ASSIGN expr NEWLINE {
          char* temp = createTemp();
          printf("%s = %s / %s\n", temp, $1, $3);
          printf("%s = %s\n", $1, temp);
      }
    | ID MOD_ASSIGN expr NEWLINE {
          char* temp = createTemp();
          printf("%s = %s %% %s\n", temp, $1, $3);
          printf("%s = %s\n", $1, temp);
      }
    | ID POW_ASSIGN expr NEWLINE {
          char* temp = createTemp();
          printf("%s = %s ** %s\n", temp, $1, $3);
          printf("%s = %s\n", $1, temp);
      }
    | ID IDIV_ASSIGN expr NEWLINE {
          char* temp = createTemp();
          printf("%s = %s // %s\n", temp, $1, $3);
          printf("%s = %s\n", $1, temp);
      }
    | NEWLINE
    ;

%%
