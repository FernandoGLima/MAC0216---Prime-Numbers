#include <stdio.h>
#include <stdlib.h>

int eh_primo(int n){
    int div=2, resto;

    while(div<n){
        resto=n%div;
        if(resto==0){
            return 0;
        }
        div++;
    }
    return 1;
}

int main()
{
    int modoexecucao, n, flag=0, primo1=2, primo2, resto;

    printf("Digite o modo de execucao e o numero:");
    scanf("%d %d", &modoexecucao, &n);

    if(modoexecucao==0){
        while(flag==0){
            n++;
            flag=eh_primo(n);
        }
        printf("%d\n", n);
    }
    else{
            while(primo1<n){
               resto=n%primo1;
                if(resto==0){
                    flag=eh_primo(primo1);
                    if(flag==1){
                        primo2=n/primo1;
                        flag=eh_primo(primo2);
                        if(flag==1){
                            flag=2;
                            goto jump;
                        }
                    }
                }
                primo1++;
            }
            jump:
                if(flag==2){
                    printf("%d %d\n", primo1, primo2);
                }
   }
    return 0;
}
