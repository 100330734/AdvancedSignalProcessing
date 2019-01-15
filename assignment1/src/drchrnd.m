function r = drchrnd(alpha,k)
%DRCHRND Draw samples from dirichlet distribution
% Input
%   alpha: Parameter of dirichlet (k dimension for sample of dimension k)
%   n: Number of samples drawn.
% Output
%   r: Dirichlet samples of size (n,k)

n = length(alpha);
r = gamrnd(repmat(alpha,k,1),1,k,n);
r = r ./ repmat(sum(r,2),1,n);

end

