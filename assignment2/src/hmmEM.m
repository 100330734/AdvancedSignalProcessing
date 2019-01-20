function [Q,pi,theta,r,labels] = hmmEM(mu,pi,A,theta,epsilon,max_iter)

K = size(pi,1);
N = length(mu);
I = size(theta,2);
T = length(mu{1});

iter = 0;
Q = zeros(1,max_iter);
converged  = false;

% Initialize
gamma = cell(1,N);
xi = cell(1,N);
alpha = cell(1,N);
beta = cell(1,N);
Pbmat = cell(1,N);

while ~converged && iter~=max_iter
      
   iter = iter + 1; 
   
   for n =1:1:N
       % Calculate P_b_n
       Pbmat{n} = calculatePbmat(mu{n},theta);
       
       % expectation
       [gamma{n}, xi{n}, alpha{n}, beta{n}] = expectation(pi,A,Pbmat{n});
   end
   
   % maximization
   [pi_new,A_new,theta_new] = maximization(gamma,xi,mu);  
   
   % update
   pi = pi_new;
   A = A_new;
   theta = theta_new;

   % evaluation
   Q(iter) = evaluation(pi,A,theta,gamma,xi,mu);
   
   fprintf('Iteration %d: Q: %d \n',iter,Q(iter))
   if iter==1, continue; end
   
   converged = convergenceTest(Q(iter),Q(iter-1),epsilon);
end

% Topic assignation
[~,labels] = max(r,[],2);

if iter==max_iter
   warning(['Maximum iteration reached: ' num2str(iter)]);
   return;
end
fprintf('Convergence reached at iteration %d \n',iter)
Q(Q==0) = [];

end

