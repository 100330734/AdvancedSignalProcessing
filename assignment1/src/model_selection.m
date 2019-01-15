function [aic,bic] = model_selection(ll,k,I,N)
% Calculate AIC and BIC for model selection of the number of topics K

num_param = k*(I-1)  + ... % theta parameter;
            k-1;           % pi parameter
aic = -2*ll + 2 * num_param;
bic = -2*ll + num_param * log(N);

end

