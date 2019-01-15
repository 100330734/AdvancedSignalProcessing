function log_prior = log_betaprior(alpha)
%LOG_BETAPRIOR Computes log(1/B(alpha)), where B is the Beta function. Beta
% function from:
% https://es.wikipedia.org/wiki/Distribuci%C3%B3n_de_Dirichlet.
%
%

alpha_0 = sum(alpha);
log_prior = gammaln(alpha_0) - sum(gammaln(alpha));

end

