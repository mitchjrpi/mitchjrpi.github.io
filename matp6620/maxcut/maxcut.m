load A5a.mat A;
[msize,nsize]=size(A);
msize
cvx_solver sdpt3;
cvx_begin
variable X(msize,msize) symmetric;
X == semidefinite(msize);
for i=1:msize
    X(i,i)==1;
end
maximize 0.25 * trace(A * X)
cvx_end
rank(X)
format long
eigs(X)
format short
Lt=chol(X);
ratio=zeros(50,1);
ratiobest=0;
sdpval=0.25 * trace(A * X)
GWassignbest=zeros(msize,1);
for k=1:50
v=rand(msize,1);
GWassign=Lt'*v;
for i=1:msize
    if GWassign(i) > 0
        GWassign(i) = 1;
    else
        GWassign(i) = -1;
    end
end
GWassign;
cutval=0.25*GWassign'*A*GWassign;
ratio(k)=cutval/sdpval;
if ratio(k) > ratiobest
    ratiobest=ratio(k);
    for i=1:msize
        GWassignbest(i)=GWassign(i);
    end
end
end
ratiobest
GWcolor=zeros(1,msize);
for i=1:msize
    if GWassignbest(i)>0.5
        GWcolor(i)='b';
    else
        GWcolor(i)='c';
    end
end
GWcolor=zeros(msize,3);
for i=1:msize
    if GWassignbest(i)>0.5
        GWcolor(i,1)=0;
        GWcolor(i,2)=0;
        GWcolor(i,3)=1;
    else
        GWcolor(i,1)=1;
        GWcolor(i,2)=0;
        GWcolor(i,3)=0;
    end
end
figure('Name','Cholesky rows')
hold on
th = 0:pi/50:2*pi;
xunit = cos(th);
yunit = sin(th);
h = plot(xunit, yunit);
%scatter (Lt(1,:),Lt(2,:))
scatter (Lt(1,:),Lt(2,:),[],GWcolor)
hold off

figure('Name','scaled eigenvector rows')
hold on
th = 0:pi/50:2*pi;
xunit = cos(th);
yunit = sin(th);
h = plot(xunit, yunit);
[V,D]=eig(X);
VV=zeros(msize,msize);
lambda1root=sqrt(D(msize,msize));
lambda2root=sqrt(D(msize-1,msize-1));
for i=1:msize
    VV(1,i)=V(i,msize)*lambda1root;
    VV(2,i)=V(i,msize-1)*lambda2root;
end
scatter (VV(1,:),VV(2,:),[],GWcolor)
hold off