function [pi_new,A_new,theta_new] = maximization(gamma,xi,mu)
%MAXIMIZATION M-step.
    
pi_new = pi_update(gamma); % Kx1, sum(pi_new) = 1
A_new = a_update(xi); % KxK, sum(A_new,2) = 1
theta_new = theta_update(gamma,mu); % KxI, sum(theta,2) = 1

end

function pi = pi_update(gamma)
% pi: Kx1
% N = length(gamma);
% K = size(gamma{1},2);
% pi = zeros(K,1);
% 
% pi  = sum(cat(3,gamma{:}),3);
% t = 1;
% pi = pi(t,:)./N;
% pi = pi';

N = length(gamma);
K = size(gamma{1},1);
pi = zeros(K,1);

for n=1:1:N
    pi = pi + gamma{n}(:,1);
end
pi = pi./N;
end

function A = a_update(xi)
% A:KxK
N = length(xi);
K = size(xi{1},2);
A = zeros(K,K);
for n=1:1:N
     A = A + xi{n};
%    A = A + squeeze(sum(xi{n},1));
end
A = A./sum(A,2);

end

function theta = theta_update(gamma,mu)
% theta: KxI
% 
% [T,K] = size(gamma{1});
% N = length(gamma);
% I = size(mu{1},2);
% theta = zeros(K,I);
% 
% for n = 1:1:N
%     theta = theta + transpose(gamma{n})*mu{n};
% end
% theta = theta./sum(theta,2);
% 
% theta(theta==0) = realmin;

[K,T] = size(gamma{1});
N = length(gamma);
I = size(mu{1},2);
theta = zeros(K,I);

for n = 1:1:N
    theta = theta + gamma{n}*mu{n};
end

theta(theta==0) = realmin;
theta = theta./sum(theta,2);
end

