%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE int
int yylex(void);
void yyerror(char*);
%}

%token T_RGB T_HEX
%token EOL
%token DEL_ESQ DEL_DIR 
%token FUNC_MIST FUNC_COMB FUNC_SUB FUNC_INV
%token CMD_EXT

%%

start: start comando EOL { printf("= %d\n", $2); /*avalia linha por linha os comandos*/ }
	|
	| start EOL { printf("\n"); }
	| start CMD_EXT { printf(">> Saindo...\n"); exit(0); }
	|
;


comando: T_IDEN OP_EQL expr           { $$ = $3; $1 = $3; }
    | expr                         { $$ = $1; }
;


funcao: expr OP_ADD term          { $$ = $1 + $3; }
    | expr OP_SUB term         { $$ = $1 - $3; }
    | term  { $$ = $1; }
;

term: term OP_MUL unary     { $$ = $1 * $3; }
    | term OP_DIV unary       { $$ = $1 / $3; }
    | unary                     { $$ = $1; }
;

unary: OP_SUB unary            { $$ = $2 * -1; }
    | pow                       { $$ = $1; }
;

pow: factor OP_POW pow           { $$ = pow($1,$3); }
    | factor                    { $$ = $1; }
;

factor: T_RGB                                      { $$ = $1; }
    | T_HEX                                         { $$ = $1; }
    | DEL_ESQ expr DEL_DIR                        { $$ = ($2); }
;


%%
void yyerror(char *s)
{
	fprintf(stderr, ">> %s\n", s);
}
int main()
{
	printf(">> Iniciando o manipulador de cores. Digite 'sair' ou 'exit' para encerrar.\n");
	yyparse();
	return 0;
}