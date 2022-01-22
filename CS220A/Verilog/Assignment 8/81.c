#include<stdio.h>
int Sum (int n,int array[]) {
    int i, sum;
    sum = 0;
    for (i=0; i<n; i++) {
        if (i == 10) break;
        sum += array[i];
    }
    return sum;
}
int main(){
    int array[10]={-4,-5,-8,-9,0,0,0,0,0,0};
    int n, x;
    n = 3;
    x = Sum(n,array);
    printf("%d\n",x);
    return 0;
}