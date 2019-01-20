function [gamma_n, xiSummed_n, alpha_n, beta_n] = expectation(pi,A,Pbmat_n)
% Adapted from hmmFwdBack from pmtk3 code source from Murphy's book.
% Calculate p(S(t)=i | y(1:T))
% INPUT:
% pi(i) = p(S(1) = i)
% A(i,j) = p(S(t) = j | S(t-1)=i)
% Pb_mat(i,t) = p(y(t)| S(t)=i)
%
% OUTPUT
% gamma(i,t) = p(S(t)=i | y(1:T)), (KxT) 
% xiSummed(i, j) = sum_t=2:T p(S(t) = i, S(t+1) = j | y(1:T)), t=2:T  (KxK)
%       The output constitutes the expected sufficient statistics for the 
%       transition matrix, for a given observation sequence. 
% alpha(i,t)  = p(S(t)=i| y(1:t)), (KxT) 
% beta(i,t) propto p(y(t+1:T) | S(t=i)), (KxT) 


[alpha_n, beta_n] = hmmFwdBack(pi,A,Pbmat_n);

gamma_n = calculateGamma(alpha_n,beta_n);
xiSummed_n = calculateXi(alpha_n,beta_n,A,Pbmat_n);

end

function gamma = calculateGamma(alpha_n, beta_n)
% gamma(i,t) = p(S(t)=i | y(1:T)), (KxT) 
% % gamma: KxT
% gamma = alpha_n.*beta_n; 
% gamma = gamma./sum(gamma,2); 
% % gamma_n = normalize(gamma_n);

% gamma: TxK
gamma = alpha_n.*beta_n; 
gamma = gamma./sum(gamma,1); % make each column sum to 1

end

function xi = calculateXi(alpha_n,beta_n,A,Pb_mat)
% xiSummed(i, j) = sum_t=2:T p(S(t) = i, S(t+1) = j | y(1:T)), t=2:T  (KxK)

% [T,K] = size(alpha_n);
% alpha_slice = alpha_n(1:T-1,:); % alpha slice from t=1:T-1
% beta_slice= beta_n(2:T,:); % beta slice from t=2:T
% Pb_slice = Pb_mat(2:T,:); % pb_mat slice from t=2:T
% % 
% % % Replicate along K and permute to do a 1-step calculation.
% % alpha_rep = repmat(alpha_slice,1,1,K);
% % a_rep = repmat(A,1,1,T-1);
% % a_rep = permute(a_rep, [3, 1, 2]);
% % Pb_rep = repmat(Pb_slice,1,1,K);
% % beta_rep = repmat(beta_slice,1,1,K);
% % 
% % xi = alpha_rep .* a_rep .* Pb_rep .* beta_rep;
% % 
% % % Normalisation:
% % % N = squeeze(sum(sum(xi,1),2));
% % % N = repmat(N, 1, T-1, K);
% % % N = permute(N,[2,1,3]);
% % % xi = xi ./ N;
% 
% xi = zeros(T-1,K,K);
% 
% for t = T-1:-1:1
%     b = beta_n(t+1,:).*Pb_mat(t+1,:);
%     xi_t = A.*(alpha_n(t,:)'*b);
%     xi_t = xi_t./sum(xi_t,2);
%     xi(t,:,:) = xi_t;
% end

%% Compute the sum of the two-slice distributions over hidden states
%
% Let K be the number of hidden states, and T be the number of time steps.
% Let S(t) denote the hidden state at time t, and y(t) be the (not
% necessarily scalar) observation at time t. 
%
%% INPUTS:
% 
% alpha, and beta are computed using e.g. hmmFwdBack, A is the state
% transition matrix, whose *rows* sum to one, and B is the soft evidence. 
% 
% alpha(j, t)      = p( S(t) = j  | y(1:t)    )   (KxT) 
% beta (j, t) propto p( y(t+1:T)  | S(t)   = j)   (KxT)
% A    (i, j)      = p( S(t) = j  | S(t-1) = i)   (KxK) 
% B    (j, t)      = p( y(t)      | S(t)   = j)   (KxT)
% 
%% OUTPUT: 
% xiSummed(i, j) = sum_t=2:T p(S(t) = i, S(t+1) = j | y(1:T)), t=2:T   (KxK)
% The output constitutes the expected sufficient statistics for the 
% transition matrix, for a given observation sequence. 
%%

% This file is from pmtk3.googlecode.com

[K, T] = size(Pb_mat);
xiSummed = zeros(K, K);
for t = T-1:-1:1
    b        = beta_n(:,t+1) .* Pb_mat(:,t+1);
    xit      = A .* (alpha_n(:,t) * b');
    xiSummed = xiSummed + xit./sum(xit(:));
end
xi = xiSummed;

end
