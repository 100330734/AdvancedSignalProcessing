function [tf_matrix] = tf_matrix_computer(seq_doc,dictionary)
%TF_MATRIX_COMPUTER Summary of this function goes here
%   Detailed explanation goes here
I = length(dictionary);
Tn = length(seq_doc); % number of documents

tf_matrix = zeros(Tn,I);

for i = 1:Tn
    seq_doc_i = seq_doc{i};
    seq_doc_i(:,1) =  seq_doc_i(:,1) +1 ; % +1 because BD was given 0-index.
    tf_matrix(i,seq_doc_i(:,1)) =  seq_doc_i(:,2);
end

end

