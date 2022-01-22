a=[2 1 0;0 2 0;0 0 2];
i=0;
maxiter=1e5;
xm=[0; 1; 1];
while(i<maxiter)
    ym=a*xm;
    xm=ym/norm(ym);
    i=i+1;
end;
xm
[v,w]=eig(a);
% 2 0; 2, 2
lamb=(xm.'*a*xm)/(xm.'*xm)