function [alpha_n,beta_n] = hmmFwdBack(pi,A,Pb_mat)
% Adapted from hmmFwdBack from pmtk3 code source from Murphy's book.
% Calculate p(S(t)=i | y(1:T))
% INPUT:
% initDist(i) = p(S(1) = i)
% transmat(i,j) = p(S(t) = j | S(t-1)=i)
% softev(i,t) = p(y(t)| S(t)=i)
%
% OUTPUT
% gamma(i,t) = p(S(t)=i | y(1:T))
% alpha(i,t)  = p(S(t)=i| y(1:t))
% beta(i,t) propto p(y(t+1:T) | S(t=i))
% loglik = log p(y(1:T))
% 
% % Calculate alpha: TxK
% alpha_n = hmmForward(pi,A,Pb_mat);
% % Calculate beta: TxK
% beta_n = hmmBackwards(A,Pb_mat);

% Calculate alpha: KxT
alpha_n = hmmForward(pi,A,Pb_mat);
% Calculate beta: KxT
beta_n = hmmBackwards(A,Pb_mat);
end

function  alpha_n =  hmmForward(pi,A,Pb_mat)
% Adapted from hmmFilter from pmtk3 code source from Murphy's book.
% INPUT:
% pi(i) = p(S(1) = i)
% A(i,j) = p(S(t) = j | S(t-1)=i)
% Pb_mat(i,t) = p(y(t)| S(t)=i)
% OUTPUT
% alpha(i,t)  = p(S(t)=i| y(1:t)), KxT

% [T,K] = size(Pb_mat);
% alpha_n = zeros(T,K);
% 
% % log_alpha_1 = log(pi) + mu(1,:)*log(theta');
% alpha_n(1,:) = Pb_mat(1,:).*pi';
% alpha_n(1,:) = alpha_n(1,:)./sum(alpha_n(1,:));
% 
%     for t = 2:1:T
%         AT = A'; % important!
%         prob_b_t = exp( sum(mu(t,:) .* log(theta')));
%         alpha_n(t,:) = alpha_n(t-1,:) .* Pb_mat(t,:)*AT;
%         alpha_n(t,:) = (alpha_n(t-1,:)*AT) .* Pb_mat(t,:);
%         alpha_n(t,:) = alpha_n(t,:)./sum(alpha_n(t,:));
%     end

[K,T] = size(Pb_mat);
alpha_n = zeros(K,T);

% log_alpha_1 = log(pi) + mu(1,:)*log(theta');
alpha_n(:,1) = Pb_mat(:,1).*pi;
alpha_n(:,1) = alpha_n(:,1)./sum(alpha_n(:,1));

for t = 2:1:T
    AT = A'; % important!
    alpha_n(:,t) = (AT * alpha_n(:,t-1)) .* Pb_mat(:,t);
    alpha_n(:,t) = alpha_n(:,t)./sum(alpha_n(:,t));
end


end

function beta_n = hmmBackwards(A,Pb_mat)
% Adapted from hmmFilter from pmtk3 code source from Murphy's book.
% INPUT:
% A(i,j) = p(S(t) = j | S(t-1)=i)
% Pb_mat(i,t) = p(y(t)| S(t)=i)
% OUTPUT
% beta(i,t) propto p(y(t+1:T) | S(t=i))


% [T,K] = size(Pb_mat);
% beta_n = zeros(T,K);
% beta_n(T,:) = ones(K,1);
% for t=T-1:-1:1
%     prob_b_t_plus_1 = Pb_mat(t+1,:);
%     beta_n(t,:) = A * (beta_n(t+1,:) .* prob_b_t_plus_1)';
%     beta_n(t,:)  = beta_n(t,:)./sum(beta_n(t,:));
% end

[K,T] = size(Pb_mat);
beta_n = zeros(K,T);
beta_n(:,T) = ones(K,1);
for t=T-1:-1:1
    prob_b_t_plus_1 = Pb_mat(:,t+1);
    beta_n(:,t) = A * (beta_n(:,t+1) .* prob_b_t_plus_1);
    beta_n(:,t)  = beta_n(:,t)./sum(beta_n(:,t));
end

end

