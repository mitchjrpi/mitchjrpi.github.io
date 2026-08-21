load edges8.mat edges
[msize,nsize]=size(edges);
E = ones(msize,msize);

cvx_solver sdpt3;
cvx_begin
variable X(msize,msize) symmetric;
X == semidefinite(msize);
trace(X)==1;
for i=1:msize
    for j=i+1:msize
        if edges(i,j) > 0.5
            X(i,j) == 0;
        end
    end
end
maximize trace(E * X)
cvx_end
sdpval=trace(E * X);
%rank(X)
%eigs(X)
svds(X)