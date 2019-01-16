function [r] = expectation(K,N,pi,theta,mu)
%EXPECTATION E-step

% CLIPPING
% r = zeros(N,K);
% for i = 1:N
%     for k = 1:K
%         r(i,k) = pi(k)*prod(theta(k,:).^mu(i,:));      
%     end
%     r(r==0) = 1e-323;
%     r(i,:) = r(i,:)/sum(r(i,:)); 
% end


% LOG - SUM - EXP TRICK
l_R = log(pi) ...
     + mu*log(theta)';
l_R = l_R - logsumexp(l_R,2);
r = exp(l_R);
end