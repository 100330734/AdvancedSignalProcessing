function Q = evaluation(pi,theta,prior,r,mu,MAP)
%EVALUATION Summary of this function goes here
%   Detailed expla ation goes here
K = size(theta,1);
% ML
Q = sum(r*log(pi'))+ sum(sum(r.*(mu*log(theta)')));


if(MAP)
% MAP

alpha = prior.alpha;
beta = prior.beta;

pi(pi==0) = 1e-323;
theta(theta==0) = 1e-323;

Q = Q + ...
    + log_betaprior(beta) + beta*log(pi') - sum(log(pi)) ... % Prior pi term
    + K*log_betaprior(alpha) + sum(sum(alpha*log(theta)')) - sum(sum(log(theta))); % Prior theta term
end

end