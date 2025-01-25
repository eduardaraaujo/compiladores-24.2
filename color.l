%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
extern YYSTYPE yylval;
void yyerror(char*);
%}

COLOR_RANGE [0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5]

%%
"(" {
    printf("T_ESQ  ");
	return DEL_ESQ;
}
")" {
    printf("T_DIR  ");
	return DEL_DIR;
}
"MIST"|"mist" {
    printf("T_MIST  ");
	return FUNC_MIST;
}
"COMB"|"comb" {
    printf("T_COMB  ");
	return FUNC_COMB;
}
"SUB"|"sub" {
    printf("T_SUB  ");
	return FUNC_SUB;
}
"INV"|"inv" {
    printf("T_INV  ");
	return FUNC_INV;
}


RGB\(\({COLOR_RANGE},{COLOR_RANGE},{COLOR_RANGE}\)\) {
    printf("T_RGB  ");
	return T_RGB;
}
#[0-9a-fA-F]{6} {
    printf("T_HEX  ");
	return T_HEX;
}

\n {
	return EOL;
}
[ \t]+ {/* ignora espaços e tabs */ }
"sair"|"exit"|"SAIR"|"EXIT" {
	return CMD_EXT;
}
. {
	yyerror("ERRO: Entrada não reconhecida");
	exit(1);
}

%%

int yywrap()
{
	return 1;
}