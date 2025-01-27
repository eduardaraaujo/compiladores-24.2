# Disciplina: Compiladores-24.2 (CEFET/RJ)

# Projeto: Manipulação de Cores em C

Este projeto implementa um analisador léxico e sintático em C para realizar operações de manipulação de cores, utilizando as ferramentas **Flex** e **Bison**. Ele permite trabalhar com cores no formato RGB e hexadecimal, aplicando operações como mistura, combinação, subtração e inversão.

## Funcionalidades

- Suporte a cores nos formatos **RGB(r, g, b)** e **Hexadecimal (#RRGGBB)**.
- Operações disponíveis:
  - **MIST**: Mistura de duas cores, calculando a média dos valores RGB.
  - **COMB**: Combinação de duas cores, multiplicando os valores RGB e ajustando para o intervalo válido.
  - **SUB**: Subtração de duas cores, dividindo a diferença dos valores RGB por 2.
  - **INV**: Inversão de uma cor, subtraindo seus valores RGB de 255.
- Conversão de hexadecimal para RGB.
- Impressão de cores com representação visual no terminal.

## Estrutura do Projeto

- **color.l**: Arquivo de definição do analisador léxico, criado com Flex.
- **color.y**: Arquivo de definição do analisador sintático, criado com Bison.

## Pré-requisitos

- **Flex**
- **Bison**
- **GCC**


## Como Executar

1. Clonar este repositório ou baixar os arquivos `color.l` e `color.y`.
2. Compilar e gerar o programa seguindo os comandos abaixo:

```bash
bison -d color.y
flex color.l
gcc -c color.tab.h color.tab.c lex.yy.c
gcc lex.yy.c color.tab.c -o color
```

3. Execute o programa:

```bash
./color
```

## Cadeias de Entrada

### Formatos de Cor Suportados:
- **RGB(r, g, b)**: Por exemplo, `RGB(255, 0, 0)`.
- **Hexadecimal (#RRGGBB)**: Por exemplo, `#FF0000`.

### Operações Disponíveis:
- **MIST**: Mistura de cores.
  ```
  RGB(255,0,0) MIST RGB(0,0,255)
  ```
  Resultado: `RGB(127,0,127)`.

- **COMB**: Combinação de cores.
  ```
  RGB(255,128,64) COMB RGB(128,64,32)
  ```
  Resultado: `RGB(127,32,8)`.

- **SUB**: Subtração de cores.
  ```
  RGB(200,150,100) SUB RGB(50,50,50)
  ```
  Resultado: `RGB(75,50,25)`.

- **INV**: Inversão de cor.
  ```
  INV RGB(255,128,0)
  ```
  Resultado: `RGB(0,127,255)`.

### Comando para Sair:
Digite `sair`, `SAIR`, `exit` ou `EXIT` para encerrar o programa.

## Exemplo de Uso

Entrada no terminal:
```text
RGB(255,0,0) MIST RGB(0,0,255)
INV RGB(128,128,128)
#FF0000 COMB RGB(0,255,0)
sair
```

Saída esperada:
```text
Resultado = RGB(127,0,127)
Resultado = RGB(127,127,127)
Resultado = RGB(0,127,0)
>> Bye!
```

## Notas Técnicas

- O analisador léxico utiliza expressões regulares para reconhecer padrões de entrada.
- As operações de manipulação de cores são implementadas como funções auxiliares em `color.y`.
- O programa imprime a cor resultante em formato visual no terminal, ajustando o contraste do texto com base no brilho da cor.

## Licença

Este projeto é de código aberto e pode ser utilizado para fins acadêmicos ou pessoais.

---
**Autores:** Maria Eduarda Marques de Araujo e Marcus Vinicius Gomes de Oliveira.
