AUTOR:
Fernando Gouveia Lima     NUSP: 13672710    EMAIL: FernandoLimaBusiness@gmail.com

DESCRIÇÃO:
O programa consiste na resolução dos problemas propostos pelo Ep1 da disciplina MAC0216, do curso bacharelado de ciência da
computção do IME USP-(Instituto de Matemática e Estatística da Universidade de São Paulo), ministrada pelo Daniel Macedo
Batista.
O programa resolve estes dois problemas. O primeiro problema é: dado um número inteiro maior que 1 e menor que 999999937
digitado pelo usuário o programa deve imprimir o próximo primo imediatamente superior ao valor do número digitado. 
O segundo problema consiste em: dado um número inteiro maior que 1 e menor ou igual a 999999936 digitado pelo usuário, 
verificar se este número é múltiplo de dois primos ou não, caso seja, deverá imprimir os dois primos.
Observação: O programa resolve um problema por execução, sendo o primeiro problema considerado modo 0 e o segundo o modo 1. 
O programa é um algoritmo que resolve esses problemas, escrito em linguagem C e em Assembly.

COMO COMPILAR:
Para compilar o programa em assembly basta abrir seu terminal, digitar o comando "cd /mnt/c/DiretorioExemplo/" que te 
leve para o diretório onde se encontra o arquivo executavel, em seguida deve-se digitar o comando 
"nasm -f elf64 NomedoArquivo.s" (o "nasm" representa o compilador utilizado, "elf64" caso sua cpu seja de 64 bits)
em sequência este comando "ld -s -o NomedoArquivo NomedoArquivo.o".
Para compilar o programa em C basta abrir seu terminal, digitar o comando que te levará para o diretório do arquivo em C
e depois basta digitar "gcc NomedoArquivo.c -Wall -pedantic -ansi -o2 -o Nomedoarquivo".

COMO EXECUTAR:
Para executar o programa basta digitar o comando "./NomedoArquivo", após a compilção do mesmo. Depois, o programa irá 
printar "Digite o modo de execução e o numero:". Portanto, caro usuário, você deve digitar um digito para o modo, como 
especificado a cima este deve ser 0 ou 1, após isso deve-se dar espaço e digitar um numero desejado, respeitando o tamanho
ja apresentado. Um exemplo de entrada seria "1 28213".
Com relação a saida, caso tenha selecionado o modo 0, o numero printado consiste de um primo maior do que o seu numero
digitadom no nosso exemplo seria um primo maior que 28213 que é o numero 28219. Agora no modo 1 será printado dois numeros
ou nenhum, caso não seja printado nenhum numero significa que não existe primos que multiplicados entre si daria o seu 
numero digitado, caso contrario esses dois numeros multiplicados entre si dão o seu numero.

TESTES:
Exemplos modo 0:
INPUT:0 25422        INPUT:0 69690      INPUT:0 2392183
OUTPUT:25423         OUTPUT:69691       OUTPUT:2392193
Exemplos modo 1:
INPUT:1 77	    INPUT:1 2139394     INPUT:1 932391
OUTPUT:7 11	    OUTPUT:2 1069697	OUTPUT:

DEPENDÊNCIAS:
Para compilar este programa em C é necessário o compilador gcc versão 9.4.0. Agora para compilar em Assembly é necessario 
o compilador nasm versão 2.14.02. Também é importante possuir um linker GNU ld na versão 2.34.
Este programa foi executado no sistema operacional Windows 10 64 bits, porém os comandos foram executados no 
WSL - (Subsistema windows para Linux), este oferece um ambiente linux compativel ao sistema da microsoft de forma que possa
ser executado programas nativos do sistema GNU/LINUX. A versão baixada é do Ubuntu 20.04.5LTS