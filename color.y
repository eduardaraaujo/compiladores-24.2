%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
int yylex(void);
void yyerror(char*);

char* mistura(const char* color1, const char* color2) {
	int r1, g1, b1, r2, g2, b2;
	sscanf(color1, "RGB(%d,%d,%d)", &r1, &g1, &b1);
	sscanf(color2, "RGB(%d,%d,%d)", &r2, &g2, &b2);
	int r = (r1 + r2) / 2;
	int g = (g1 + g2) / 2;
	int b = (b1 + b2) / 2;
	char* result = (char*)malloc(20 * sizeof(char));
	sprintf(result, "RGB(%d,%d,%d)", r, g, b);
	return result;
}

char* combinacao(const char* color1, const char* color2) {
	int r1, g1, b1, r2, g2, b2;
	sscanf(color1, "RGB(%d,%d,%d)", &r1, &g1, &b1);
	sscanf(color2, "RGB(%d,%d,%d)", &r2, &g2, &b2);
	int r = (r1 * r2) / 255;
	int g = (g1 * g2) / 255;
	int b = (b1 * b2) / 255;
	char* result = (char*)malloc(20 * sizeof(char));
	sprintf(result, "RGB(%d,%d,%d)", r, g, b);
	return result;
}

char* subtracao(const char* color1, const char* color2) {
	int r1, g1, b1, r2, g2, b2;
	sscanf(color1, "RGB(%d,%d,%d)", &r1, &g1, &b1);
	sscanf(color2, "RGB(%d,%d,%d)", &r2, &g2, &b2);
	int r = (r1 - r2) / 2;
	int g = (g1 - g2) / 2;
	int b = (b1 - b2) / 2;
	if (r < 0) r - 0;
	if (g < 0) g - 0;
	if (b < 0) b - 0;
	char* result = (char*)malloc(20 * sizeof(char));
	sprintf(result, "RGB(%d,%d,%d)", r, g, b);
	return result;
}

char* inversao(const char* color) {
	int r, g, b;
	sscanf(color, "RGB(%d,%d,%d)", &r, &g, &b);
	r = 255 - r;
	g = 255 - g;
	b = 255 - b;
	char* result = (char*)malloc(20 * sizeof(char));
	sprintf(result, "RGB(%d,%d,%d)", r, g, b);
	return result;
}

char* hexParaRgb(const char* hex) {
	int r, g, b;
	sscanf(hex, "#%02x%02x%02x", &r, &g, &b);
	char* result = (char*)malloc(20 * sizeof(char));
	sprintf(result, "RGB(%d,%d,%d)", r, g, b);
	return result;
}

void imprimeCor(const char* color) {
	int r, g, b;
    sscanf(color, "RGB(%d,%d,%d)", &r, &g, &b);

    // Calcular o brilho relativo
    double brilho = (0.2126 * r + 0.7152 * g + 0.0722 * b);

    // Definir a cor de fundo
    printf("\033[48;2;%d;%d;%dm", r, g, b);  

    // Se o brilho for baixo (escuro), usar texto branco; se for alto (claro), usar texto preto
    if (brilho < 128) {
        printf("\033[1;37m"); // Texto branco em negrito
    } else {
        printf("\033[1;30m"); // Texto preto em negrito
    }

    // Imprimir o valor da cor com um espaço reduzido ao redor
    printf("RGB(%d,%d,%d)", r, g, b);

    // Reset para a cor padrão e desativar negrito
    printf("\033[0m\n");
}
%}

%union {
	char* str;
}

%type <str> color expr term factor

%token <str> T_RGB T_HEX
%token DEL_ESQ DEL_DIR
%token EOL
%token CMD_EXT
%left FUNC_MIST FUNC_COMB FUNC_SUB FUNC_INV


%%

start: start expr EOL           { printf("Resultado = "); imprimeCor($2); }
	| start EOL                 { printf("\n"); }
	| start CMD_EXT             { printf(">> Bye!\n"); exit(0); }
	|                           /* Linha vazia para permitir entrada vazia ou fim da análise */
;

expr: expr FUNC_MIST term       { $$ = mistura($1, $3); }
	| expr FUNC_COMB term		{ $$ = combinacao($1, $3); }
	| expr FUNC_SUB term        { $$ = subtracao($1, $3); }
	| term  					{ $$ = $1; }
;

term: FUNC_INV factor			{ $$ = inversao($2); }
	| factor					{ $$ = $1; }
;

factor: DEL_ESQ expr DEL_DIR 	{ $$ = $2; }
	| color						{ $$ = $1; }

color: T_RGB                    { $$ = $1; }
    | T_HEX                   	{ $$ = hexParaRgb($1); }
;

%%

void yyerror(char *s) {
	fprintf(stderr, ">> %s\n", s);
}

int main() {
	yyparse();
	return 0;
}