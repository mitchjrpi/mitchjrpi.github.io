E = ones(msize,msize);
edges = floor((1+density)*rand(msize,msize));
for i=1:msize
    edges(i,i) = 0;
    for j=1:i-1
        edges(j,i)=edges(i,j);
    end
end

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
rankX=rank(X)
eigsX=eigs(X)