#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <math.h>

void mm(long long int **A,long long int **B, long long int **C,long long int m){
    for(long long int i=0;i<2;i++){
        for (long long int j=0;j<2;j++){
            for(long long int k=0;k<2;k++){
                C[i][j] = (C[i][j]+A[i][k]*B[k][j])%m;
            }
        }
    }
}
void pow_n(long long int **A,long long int n, long long int m, long long int **temp){
    if(n==2) {
        mm(A,A,temp,m);
    }
    else if(n==1){
        temp[0][0]=3;
        temp[0][1]=1;
        temp[1][0]=1;
        temp[1][1]=3;
    }
    else if(n==0){
        temp[0][0]=1;
        temp[0][1]=0;
        temp[1][0]=0;
        temp[1][1]=1;
    }
    else{
        pow_n(A,n/2,m,temp);
        //temp = temp*temp % m;
        long long int** ptr;
        ptr = (long long int**)malloc(2*sizeof(long long int*));
        for(long long int i=0;i<2;i++){
            ptr[i] = (long long int*)malloc(2*sizeof(long long int));
            for(long long int j=0;j<2;j++){
				ptr[i][j]=0;
        	}
        }
        mm(temp,temp,ptr,m);
        for(long long int i=0;i<2;i++){
            for(long long int j=0;j<2;j++){
                temp[i][j] = (ptr[i][j])%m;
                ptr[i][j]=0;
            }
        }
        
        if(n%2==1){
            mm(temp,A,ptr,m);
            for(long long int i=0;i<2;i++){
                for(long long int j=0;j<2;j++){
                    temp[i][j] = (ptr[i][j])%m;
                }
            }            
        }
    }
         
}

long long int pow_mthd(long long int **A,long long int n, long long int m, long long int **B){
    pow_n(A,n,m,B);
    return B[0][0];
}

int main(){
    long long int **A,**B,**C,n,m=1000000007;
    scanf("%lld",&n);
    A = (long long int**)malloc(2*sizeof(long long int*));
    B = (long long int**)malloc(2*sizeof(long long int*));
    C = (long long int**)malloc(2*sizeof(long long int*));
    
    for(long long int i=0;i<2;i++){
        A[i] = (long long int*)malloc(2*sizeof(long long int));
        B[i] = (long long int*)malloc(2*sizeof(long long int));
        C[i] = (long long int*)malloc(2*sizeof(long long int));
    }
    
    A[0][0]=3;
    A[0][1]=1;
    A[1][0]=1;
    A[1][1]=3;
    
    B[0][0]=0;
    B[0][1]=0;
    B[1][0]=0;
    B[1][1]=0;
    pow_n(A,n,m,B);
    printf("%lld %lld\n",B[0][0],B[1][0]);
    return 0;
}