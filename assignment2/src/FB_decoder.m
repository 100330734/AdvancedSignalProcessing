function [ states ] = FB_decoder( gamma_est )
%It decodes the sequence based on forward backward algorithm
    states = zeros(length(gamma_est), length(gamma_est{2}));
    for i = 1:length(gamma_est)
        [~, index_seq_i] = max(gamma_est{i});
        states(i,:) = index_seq_i;
    end
end

