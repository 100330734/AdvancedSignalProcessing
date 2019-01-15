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
    % MAP
    

    %% Deprecated
    
    % PI
    % FOR-LOOP FORM    
    % new_pi = zeros(K,1);
    % for k = 1:K
    %  new_pi(k) = (1/N)*sum(r(:,k));
    % end
     
    % THETA
    % FOR-LOOP FORM
    % for k = 1:K
    %     for m = 1:I
    %          suma_I_rmu(k,m) = sum(r(:,k).*mu(:,m));
    %      end     
    %  end
    %
    % suma_IK_rmu = sum(suma_I_rmu,2); 
    % new_theta = suma_I_rmu./suma_IK_rmu;
end

