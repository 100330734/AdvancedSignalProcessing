function [mu] = mu_computer(observed,dictionary)
%TF_MATRIX_COMPUTER Summary of this function goes here
%   Detailed explanation goes here
I = length(dictionary);
N = length(observed); % number of sequences
I = length(dictionary); % number of categories
Tn = length(observed{1}); % number of documents

mu = cell(1,N);

for i = 1:N
    seq_i = observed{i};
    mu{i} = tf_matrix_computer(seq_i,dictionary);
end

end

