function [tf_matrix] = tf_matrix_computer(LDAdata,dictionary)
%TF_MATRIX_COMPUTER Summary of this function goes here
%   Detailed explanation goes here
C = length(dictionary);
N = length(LDAdata); % number of documents

tf_matrix = zeros(N,C);

for i = 1:N
    tf_matrix(i,LDAdata(i).corpus(:,1)) = LDAdata(i).corpus(:,2);
end

end

