#include<stdio.h>
int main(){
    short a,b,c,d;
    a=17;
    printf("%d",a); b=-9;
    printf("%d %d",a,b); c=65;
    printf("%d %d",b,c);
    d=8*c-512*(a+b);
    printf("%d",d);
    return 0;
}