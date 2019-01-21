  close all; clear all clc;

% data processing
load('LDAdata.mat');
load('observed.mat');

%% SETUP
K = 5;
max_iter = 100;
n_init = 5;
epsilon = 1e-3;
debug = false;

print_setup(max_iter,n_init,epsilon)


%%  BAG OF WORDS - mu: (Term Frequency Matrix)
fprintf('Computing Term Frequency Matrix...\n')
N = length(observed); % number of sequences
I = length(dictionary); % number of categories
Tn = length(observed{1}); % number of documents
mu = mu_computer(observed,dictionary)';
fprintf('Done!')
% TODO: BIC CRITERION FOR K SELECTION

%% LISTS FOR DIFFERENT k
model_opt_k = cell(1,K-1);
ll_opt_k = zeros(1,K-1);

% aic_list = zeros(1,K-1);
% bic_list = zeros(1,K-1);

for k = 2:K
    
    %% LISTS
    model_cells = cell(1,n_init);
    ll = zeros(1,n_init);     
    for i = 1:1:n_init

        fprintf('------------------------------- \n');
        fprintf('Initialization %d\n',i);

        % initialization
        [pi,theta,A] = initialization(k,I);
        fprintf('Done! %d\n',i);

        % EM
        fprintf('------------------------------- \n');
        fprintf('Running EM\n');

        model = hmmEM(mu,pi,A,theta,epsilon,max_iter);
        ll(i) = model.Q(end);
        model_cells{i} = model;
    end
    
    % Obtain optimal for initializations 
    [ll_opt_k(k-1), idx_opt] = max(ll);
    model_opt_k{k-1} = model_cells{idx_opt};
%     [aic_list(k-1), bic_list(k-1)] = model_selection(ll_opt_k(k-1),k,I,N);
    
    opt_model_k = model_opt_k{k-1};
    % Plot Q
    fprintf('------------------------------- \n');
    fprintf('Plotting Q: \n');
    plot_Q(opt_model_k.Q,k)

    fprintf('Done!\n');

    % Compare FB Decoder and Viterbi decoder
    [opt_model_k.states_FB, opt_model_k.states_Vit] = compareFBvsViterbi(opt_model_k);

%     % Visualize R
%     fprintf('------------------------------- \n');
%     fprintf('Visualize R: \n');
%     visualize_R(r_opt_k{k-1},k,MAP)
%     fprintf('Done!\n'); 
%     
%     % Visualize theta
% %     fprintf('------------------------------- \n');
% %     fprintf('Visualize theta: \n');
% %     visualize_theta(theta_opt_k{k},k,MAP)
% %     fprintf('Done!\n'); 
%     
%     % Word Cloud
%     fprintf('------------------------------- \n');
%     fprintf('Visualize Word Cloud: \n');
%     create_wordcloud(k,dictionary,mu,labels_opt_k{k-1},MAP)
%     fprintf('Done!\n');     
%     
%     
end

fprintf('Done!\n');     

close all;






