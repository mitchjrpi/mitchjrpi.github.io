%%claim the LEPC model
% x \in R^n, y \in R^m, f \in R^k
% min c*x + d*y
% s.t. A*x  >= f
%      0 <= y complements to q + N*x + M*y >= 0

% generating feasible LPEC

function [params] = generateLPEC(n,m,k)

density = 0.1;

params.n = n;
params.m = m;
params.k = k + params.n;

params.c = rand(n,1);
params.d = rand(m,1)*2+1;

params.A = sprand(k,n,density);
params.A = sparse([params.A; eye(n)]);

params.B = zeros(k,m);
params.B = sparse([params.B; zeros(n,m)]);

sep = floor(rand(1)*params.m);
denM = (2000-m)/m^2;
E = sprand(sep, params.m-sep, denM);
E = E*2 - (E ~= 0);
params.M = sparse([diag(rand(sep,1)*2),E; -E', diag(rand(params.m-sep,1)*2)]);

params.N = sprand(m,n,density);
params.N = params.N*2 - (params.N ~= 0);

params.f = zeros(params.k,1);
params.q = rand(m,1)*(-10) - 10;

params.x = abs(randn(n,1));
params.y = randn(m,1);
params.y = (abs(params.y) + params.y)/2;

params.f = params.A*params.x + params.B*params.y - abs(randn(size(params.f)));
params.f(k+1 : params.k) = 0;

