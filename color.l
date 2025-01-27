%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "color.tab.h"
void yyerror(char*);
%}

COLOR_RANGE [ \t]*[0-9]{1,2}[ \t]*|[ \t]*1[0-9][0-9][ \t]*|[ \t]*2[0-4][0-9][ \t]*|[ \t]*25[0-5][ \t]*

%%
RGB\(({COLOR_RANGE},{COLOR_RANGE},{COLOR_RANGE})\) {
	yylval.str = strdup(yytext);
	return T_RGB;
}
#[0-9a-fA-F]{6} {
	yylval.str = strdup(yytext);
	return T_HEX;
}
"(" {
	return DEL_ESQ;
}
")" {
	return DEL_DIR;
}
"MIST"|"mist" {
	return FUNC_MIST;
}
"COMB"|"comb" {
	return FUNC_COMB;
}
"SUB"|"sub" {
	return FUNC_SUB;
}
"INV"|"inv" {
	return FUNC_INV;
}
\n {
	return EOL;
}
[ \t]+
"sair"|"exit"|"SAIR"|"EXIT" {
	return CMD_EXT;
}
. {
	yyerror("ERROR: Unrecognized input!");
	exit(1);
}

%%

int yywrap()
{
	return 1;
}