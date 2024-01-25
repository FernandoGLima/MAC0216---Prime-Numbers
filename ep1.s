section .text 
        global _start


        ; O programa a seguir, feito por Fernando Gouveia Lima, consiste na resolucao dos problemas propostos
        ; pelo Ep1 da disciplina MAC0216, do curso bacharelado de ciencia da computacao do IME - USP, ministrada
        ; pelo Daniel Macedo Batista.
        ; Sucintamente, o programa ira receber um input que contem  dois numeros, exempo - 1 1678912, o primeiro 
        ; representa em qual modo o programa ira entrar, ou seja, qual problema ele ira resolver. O modo 0 consiste
        ; de achar o proximo numero primo maior que o seu numero digitado e printa-lo.
        ; o modo 1 consiste de verificar se existe dois numeros primos que multiplicados entre si, darao o seu 
        ; numero digitado, caso exista printa-los



        ; Como de costume, as funcoes estao apresentadas antes do que seria o 'main' - fazendo uma analogia com a linguagem c.


        ; A funcao eh_primo consiste em receber um numero e verificar se ele e ou nao primo
        ; Observacao - Comparando este codigo com o codigo redigido em C, o registrador rcx eh equivalente a minha
        ; variavel 'div' utilizada la. Assim como o rdx equivale a variavel resto de la, pois em assembly o resto
        ; de uma divisao e armazenado no rdx

   eh_primo:
            mov rcx, 2             ; adiciona 2 no contador, o rcx funcionara como contador e tambem como divisor do numero que deseja saber se e primo
            xor rdx, rdx           
            mov r15, rax           ; rax possui o numero que desejamos verificar se eh ou nao primo, deixamos em r15 tambem

       loopeh_primo:
            cmp rcx, rax            
            je primo               ; Caso nenhum numero abaixo do suposto primo dividiu ele, logo ele eh primo
            
            div rcx                ; isso ocasionara em rax=rax/rcx e rdx=rax%rcx
            
            cmp rdx, 0              
            je nao_primo           ; Caso o resto da divisao seja zero, o suposto primo foi divido, ou seja, ele nao eh primo
            
            inc rcx                ; incrementa contador          
            
            mov rax, r15           ; retorna o valor do numero para o rax, para testar o proximo divisor   
            xor rdx, rdx           ; zera o rdx, para evitar erros de funcionamento
            
            jmp loopeh_primo       ; laco while - analogo ao C    

       primo: 
            mov r11, 1             ; r11 funcionara como uma flag, caso seja armazenado 1 nele, indicara que o 
            ret                    ; suposto primo, que esta no rax, eh realmente primo. Caso esteja 0 e que nao eh

       nao_primo: 
            mov r11, 0
            ret



   print_text:
            mov rax, 1              ; Esta "funcao" ira printar a mensagem pedindo ao usuario o input dele
            mov rdi, STDOUT         ; similar o que foi implementado no codigo em C
            mov rsi, msg
            mov rdx, tamanho
            syscall

            ret



        ; Esta funcao print consiste em printar os numeros na tela. Armazenado no rax esta o numero que desejamos printar na tela
        ; para isso deve-se converter este inteiro em uma string, adicionando 48 seguindo parametros da tabela ascii.
        ; Para isso sera feito passo a passo, byte a byte. Iremos dividir o rax por 10 e pegar o resto da divisao soma-la com 48
        ; e armazenar em um espaco reservado representado pela variavel nao inicializada 'saida' e depois sera printado numero a numero
        ; Observacao - 'saida' funciona como um "ponteiro" apontando para o primeiro espaco reservado. 
        ; E utilizamos 'saidap', pois em loops com syscall existe o risco do rcx ser alterado e de perder a posicao que ele estava apontando
   print:
            mov rcx, saida            
            mov [saidap], rcx          ; rcx e saidap funcionarao como ponteiros


       loop_print:
            cmp rax, 0                 ; reiterando rax=rax/r10 ou seja enquanto rax nao for 0 continua no loop para retirar todos os numeros
            je fim_loop_print

            xor rdx, rdx
            div r10                     ; dentro de r10 esta o valor 10
            add rdx, 48                 ; transforma em string
            mov [rcx], dl               ; move o byte, um digito 

            inc rcx
            mov [saidap], rcx

            jmp loop_print
     
      fim_loop_print:

        loop_print2:
            mov rcx, [saidap]           ; os numeros transformados em string foram adicionados ao contrario,
                                        ; se o numero era 123 agora estao 321, por isso deve-se printar ao contrario
            mov rax, 1
            mov rdi, STDOUT             
            mov rsi, rcx                ; chamada de sistema para printar o numero
            mov rdx, 1
            syscall

            mov rcx, [saidap]
            dec rcx                     ; devido ao motivo assima decrementa-se rcx
            mov [saidap], rcx

            cmp rcx, saida
            jge loop_print2

            
            mov byte [rcx], ' '         ; chamada de sistema para printar espaco, para nao grudar os 2 numeros no modo 1    
            mov rax, 1
            mov rdi, STDOUT
            mov rsi, rcx
            mov rdx, 1
            syscall

            ret



        ; Esta funcao consiste em armazenar e converter o input do usuario, converter de string para int agora subtrai-se 48.
        ; Ira ser feito passo a passo novamente, primeiro armazena-se o primeiro numero que representa o modo, 
        ; depois avanca com o ponteiro para pegar digito a digito do numero digitado, para isso deve se multiplicar por 10 cada vez que pega um numero e soma o proximo, ate chegar no ultimo, nao multiplica o ultimo
   scanf:
            mov rax, 0              
            mov rdi, STDIN
            mov rsi, string             ; chamada de sistema para receber o input
            mov rdx, 15
            syscall

            mov rcx, 0
            mov r14, rax                    ; rax contem a quantidade de caracters do input, agora r14 tambem contem
            mov bl, byte [string+rcx]        ; pega-se o primeiro caracter que representa o modo   
            sub bl, 48                       ; transforma em int
            mov [modo], bl                  
            mov r8, [modo]                   

            add rcx, 2                      ; rcx agora aponta para o primeiro caracter do numero digitado
            dec r14                         ; decrementa em r14 para nao pegar o caracter representado pelo enter         
            mov r10, 10                     ; r10 recebe o valor 10 para ser utilizado na multiplicacao 
            xor rax, rax
            xor r9, r9

      loopscan:
            cmp rcx, r14                    ; informalmente compara quantos digitos do numero falta pegar e quantos foram pegos
            je fimscan

            mov rax, r9
            xor r9, r9  
            mul r10                         
            add r9, rax

            mov bl, byte [string+rcx]       ; retira digito a digito e transforma de string em numero inteiro
            sub bl, 48
            mov [numero], bl
            add r9, [numero]

            inc rcx
            jmp loopscan

      fimscan:
            ret
            ; OBSERVACAO - Ao longo do programa o r8 sera utilizado como se fosse o modo e tambem ele representa 
            ; a variavel modoexec - Analogia com o codigo em C
            ; e o r9 sera utilizado como se fosse a variavel n - do codigo em c.







  _start:
            call print_text         ; chama a funcao para printar a mensagem na tela
            call scanf              ; chama o scan para receber o input


            cmp r8, 0               ; Reiterando o r8 representa a variavel modoexec dependendo do valor, 0 ou 1, um dos problemas sera resolvido
            jne modo_exec1



            xor r11, r11            ; Reiterando o r11 sera usado como uma flag, ele e equivalente a variavel flag do codigo em C 
     
      loop_primomaior:
            cmp r11, 0               
            jne achouprimo            

            inc r9                   ; incrementa o numero digitado para achar o proximo primo imediatamente superior ao numero digitado
            mov rax, r9
            call eh_primo            ; chama a funcao para testar se ele eh primo
            jmp loop_primomaior

      achouprimo:
            mov rax, r9              ; rax recebe o numero primo  
            call print               ; chama a funcao para printar o numero
            jmp fim




      modo_exec1:                   ; Modo 1
            xor r11, r11            ; zera a flag
            mov r12, 2              ; OBSERVACAO o r12 sera equivalente a variavel primo1 do codigo em c, ou seja ele sera um contador e ao mesmo tempo sera um suposto primo divisor do numero digitado
            mov rax, r9             
            xor rdx, rdx
      
      loop_primo1: 
            cmp r12, r9
            je fim
              
            div r12                ; novamente rax=rax/r12  rdx=rax%r12
              
            cmp rdx, 0             ; verifica se o primo1 divide n(numero digitado), ou seja, ve se o resto eh 0
            jne incrementa_primo1

              
            mov rax, r12           ; verifica se esse primo1(r12) que dividiu n(r9), se ele eh primo
            call eh_primo
              
            cmp r11, 1             ; flag ira indicar se eh ou nao primo, caso nao seja incrementa o contador/suposto divisor e primo
            jne incrementa_primo1
              
              
            mov rax, r9            ; volto o n para o rax para dividir ele e obter o suposto primo2 - analogia com o codigo em C
            div r12                ; divido o numero digitado pelo r12(primo1)
            call eh_primo          ; no rax esta o suposto segundo primo (primo2 - variavel em c), por isso chama a funcao para verificar

            cmp r11, 1              
            jne incrementa_primo1       ; caso nao seja primo vai no loop while

            mov r11, 2                  ; atribuo 2 na flag para dizer que foi encontrado os 2 primos 
            mov r13, rax                ; salva o primo2 no r13 
            jmp verifica_primo1primo2

      incrementa_primo1:
            inc r12             ; Caso nao encontrado os 2 primos incrementa o primo1 e testa novamente se ele e divisor do numero digitado se eh primo
            xor rdx, rdx
            mov rax, r9         ; coloca o n(numero digitado) no rax para dividir novamente por um suposto primo incrementado
            jmp loop_primo1

    
    
      verifica_primo1primo2:
            cmp r11, 2            ; verifica se achou os 2 primos que multiplicados entre si da o numero digitado
            jne fim

            mov rax, r12           ; se sim printa eles
            call print
            mov rax, r13   
            call print


      fim:      
            mov byte [Pula_linha], 0x0A         ; chamada de sistema para printar na tela um pula linha
            mov rax, 1
            mov rdi, STDOUT
            mov rsi, Pula_linha
            mov rdx, 15
            syscall
                
                
            mov rax, 60                         ; chamada de sistema para encerrar o programa
            mov rdi, 0
            syscall



section .data
        msg: db "Digite o modo de execucao e o numero:"             
        tamanho: equ $ - msg
     
        STDIN: EQU 0
        STDOUT: EQU 1
        

section .bss
        string: resb 15
        modo: resb 10
        numero: resb 10
        saida: resb 15
        saidap: resb 15
        Pula_linha: resb 15
