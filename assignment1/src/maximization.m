function [new_pi,new_theta] = maximization(K,N,I,r,mu,prior,MAP)
%MAXIMIZATION M-step.

    %% MAP
    
    if MAP
    % * NOTE: Matlab broadcasting used!
    
    % pi
    new_pi = sum(r,1) + (prior.beta -1); 
    new_pi = new_pi./(N + sum(prior.beta) - K);
    % theta
    num = r'*mu + (prior.alpha -1);
    den = (sum(r'*mu,2)' + sum(prior.alpha,2)' -I);
    new_theta = bsxfun(@rdivide,num,den');
    
    %  new_theta = new_theta./ (sum(r'*mu,2)' + sum(prior.alpha,2)' -I);
    return;
    end    
    
    %% ML
    
    % pi 
    new_pi = sum(r,1)/N;
    % theta
    new_theta = r'*mu./sum(r'*mu,2);
    new_theta(new_theta==0) = realmin;
    % MAP
    
end

