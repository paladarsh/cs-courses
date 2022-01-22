#include <stdio.h>
#include <time.h>
long long int** ProductM2(long long int A[2][2], long long int B[2][2]){
    long long int C[2][2] = {{(A[0][0]*B[0][0])%1000000007 + (A[0][1]*B[1][0])%1000000007, (A[0][0]*B[0][1])%1000000007 + (A[0][1]*B[1][1])%1000000007}, {(A[1][0]*B[0][0])%1000000007 + (A[1][1]*B[1][0])%1000000007, (A[1][0]*B[0][1])%1000000007 + (A[1][1]*B[1][1])%1000000007}} ;
    return C;
}
long long int** PowM(long long int A[2][2], int n){
    if(n==0){
        long long int I[2][2] = {{1, 1}, {1, 1}};
        return I;
    }
    if(n%2==0){
        long long int C[2][2] = ProductM2(PowM(A, n/2), PowM(A, n/2));
        return C;
    }
    else{
        long long int C[2][2] = ProductM2(A, ProductM2(PowM(A, n/2), PowM(A, n/2)));
        return C;
    }
}
long long int** ProductM1(long long int A[2][2], long long int B[2][1]){
    long long int C[2][1] = {{A[0][0]*B[0][0]+A[0][1]*B[1][0]}, {A[1][0]*B[0][0]+A[1][1]*B[1][0]}};
    return C;
}
int main() 
{
    long long int A[2][2] = {{3, 1}, {1, 3}};
    int n;
    scanf("%d", &n);
    long long int C[2][1] = {{1}, {0}};
    long long int UD[2][1] = ProductM1(PowM(A, n), C);
    printf("%d", UD[0][0]);
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */    
    return 0;
}
A2Q1_decoder3to8.v, A2Q1_encoder8to3.v, A2Q1_top.v
A2Q2_priority_encoder3to8.v, A2Q2_top.v
A2Q3_blink.v, A2Q3_top.v
A2Q4_rotate.v, A2Q4_top.v