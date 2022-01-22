#include<stdio.h>
#include<math.h>
int main(){
    int a=0xff0;
    a=a>>1;
    // int b=-128;
    int b=0;
    printf("%d",a+b);
    // printf("%#o",a+b);
    // printf("%d",a%128);
    // printf("%b",a+b);
    return 0;
}