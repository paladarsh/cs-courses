#include<stdio.h>
int main(){
    unsigned int x=0x12345678;
    unsigned char z=*(char *)&x;
    printf("%#x\n",z);
    return 0;
}