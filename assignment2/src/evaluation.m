function Q = evaluation(pi,A,theta,gamma,xi,mu)
%EVALUATION Summary of this function goes here

N = length(gamma);
T = size(mu{1},1);

pi_term = 0;
A_term = 0;
theta_term = 0;

for n = 1:1:N
    % pi term
    pi_term = pi_term + gamma{n}(:,1)'*log(pi);
    
    % a term
%     rep_A = repmat(A,1,1,T-1);
%     rep_A = permute(rep_A, [3, 1, 2]);
%     A_term = A_term + sum(sum(sum(xi{n}.*log(rep_A))));

    A_term = A_term + sum(sum(xi{n}.*log(A)));
    
    % theta term
    prod_term = gamma{n}'.*(mu{n}*log(theta'));

    theta_term  = theta_term + sum(sum(prod_term)); 
end

Q = pi_term + A_term + theta_term;
end