#include<iostream>
#define size 1000010
#define min_val -1e9

using namespace std;

//Correct code but different logic to be implemented

int r_move[4]={1,0,-1,0};
int c_move[4]={0,1,0,-1};

int qu[2][size];
int front=-1;
int rear=-1;
int count=0;
int ans=0;
// int R,C;
void  push(int i, int j){
    if(front==-1){front=0;}
    rear++;
    qu[0][rear]=i;
    qu[1][rear]=j;
    count++;
}

void pop(){
    front++;
    count--;
    if(front>rear){front=-1;rear=-1;}
}

bool isempty(){
    return count==0;
}

int top_x(){
    return qu[0][front];
}

int top_y(){
    return qu[1][front];
}


void bfs(int **M,  int R, int C){
    int temp=1;
    while(isempty()==0){
        temp=1;
        int x_curr=top_x();
        int y_curr=top_y();
        while(x_curr!=min_val || y_curr!=min_val){
            for(int k=0;k<4;k++){
                int x_new=x_curr+r_move[k];
                int y_new=y_curr+c_move[k];
                if(k==3){
                    pop();
                    x_curr=top_x();
                    y_curr=top_y();
                }
                if((x_new < 0) || (y_new<0) || (x_new>=R) || (y_new>=C) ||(M[x_new][y_new]!=1))continue;
                else{
                    push(x_new,y_new);
                    M[x_new][y_new]=2;
                    ans+=temp;
                    temp=0;
                }
            }
            
        }
        pop();
        if(isempty()){continue;}
        else{
            push(min_val,min_val);
        }
    }
    return;
}

int main(){
    int R,C;
    cin>>R>>C;
    int **M;
    M = (int**)malloc(sizeof(int *) * R);
    for(int i=0;i<R;i++){
        M[i] = (int*)malloc(sizeof(int) * (C));  
    }
    for(int i=0;i<R;i++){
        for(int j=0;j<C;j++){
            cin>>M[i][j];
            if(M[i][j]==2) {push(i,j);}
        }
    }
    push(min_val,min_val);
    bfs(M,R,C);

    int count_1=0;
    for(int i=0;i<R;i++){
        for(int j=0;j<C;j++){
            if(M[i][j]==1){count_1++;break;}
        }
    }
    if(count_1){cout<<-1<<endl;}
    else{
        cout<<ans<<endl;
    }
    return 0;
}