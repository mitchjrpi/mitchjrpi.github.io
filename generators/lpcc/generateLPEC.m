%%claim the LEPC model
% x \in R^n, y \in R^m, f \in R^k
% min c*x + d*y
% s.t. A*x + B*y >= f
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

params.B = sprand(k,m,density);
params.B = params.B*2 - (params.B ~= 0);
params.B = sparse([params.B; zeros(n,m)]);

params.M = sprand(m,m,density);

params.N = sprand(m,n,density);
params.N = params.N*2 - (params.N ~= 0);

params.f = zeros(params.k,1);
params.q = zeros(m,1);

params.x = abs(randn(n,1));
params.y = randn(m,1);
params.y = (abs(params.y) + params.y)/2;

params.f = params.A*params.x + params.B*params.y - abs(randn(size(params.f)));
params.f(k+1 : params.k) = 0;

params.I = find(params.y == 0);
params.J = find(params.y > 0);
params.q(params.J) = -params.N(params.J,:)*params.x - params.M(params.J,:)*params.y;
params.q(params.I) = -params.N(params.I,:)*params.x - params.M(params.I,:)*params.y + abs(randn(size(params.I)));


