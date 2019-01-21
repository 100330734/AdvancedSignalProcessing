function [ states] = viterbi_decoder( pi_hat, A_hat, Pb_mat )

    K = length(pi_hat); % Number of states
    N = length(Pb_mat); % Number of sequences
    T = size(Pb_mat{1},2); % Number of documents
    
    % Initialise Viterbi parameters
    delta = zeros(K, T, N);
    fi = zeros(K, T, N);
    states = zeros(N, T);    
    
    % Forward Step:
    % Obtain delta_1
    for n = 1:N
        delta(:,1,n) = pi_hat .* Pb_mat{n}(:,1);
    end
    
    % Obtain delta_t and fi_t
    for t = 2:T
        for n = 1:N
            term = max(A_hat.*repmat(delta(:,t-1,n),1,K));
            [~, index] = max(A_hat.*repmat(delta(:,t-1,n),1,K));
            index = index';
            delta(:,t,n) = Pb_mat{n}(:,t) .*term';
            fi(:,t,n) = index;
        end
    end
    
    % Backward Step:
    % Compute the argmax(delta_T) for the last time instant of delta
    [~, states(:,T)] = max(delta(:,T,:));
    % Compute iterativelY the rest of the estimated sequence
    for n = 1:N
        for t = T-1:-1:1
            states(n,t) = fi(states(n,t+1),t+1,n);
        end
    end    
end

