#include<stdio.h>
int main(){
    unsigned int a = 0xFFFFFFF0;
    unsigned int b = 0xF;
    int x = 0xFFFFFFF0;
    int y = 0xF;
    int c = 0;
    if (a < b) c++;
    else c--;
    if (x < y) c++;
    else c--;
    printf("%x %x %x %x %d\n",a,b,x,y,c);
    printf("%u %u %d %d %d\n",a,b,x,y,c);
    return 0;
}