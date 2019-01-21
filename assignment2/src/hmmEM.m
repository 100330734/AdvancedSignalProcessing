function model = hmmEM(mu,pi,A,theta,epsilon,max_iter)

K = size(pi,1);
N = length(mu);
I = size(theta,2);
T = length(mu{1});

iter = 0;
Q = zeros(1,max_iter);
converged  = false;

% Initialize
gamma = cell(1,N);
xiSummed = cell(1,N);
alpha = cell(1,N);
beta = cell(1,N);
Pb_mat = cell(1,N);

while ~converged && iter~=max_iter
      
   iter = iter + 1; 
   
   for n =1:1:N
       % Calculate P_b_n
       Pb_mat{n} = calculatePbmat(mu{n},theta);
       
       % expectation
       [gamma{n}, xiSummed{n}, alpha{n}, beta{n}] = expectation(pi,A,Pb_mat{n});
   end
   
   % maximization
   [pi_new,A_new,theta_new] = maximization(gamma,xiSummed,mu);  
   
   % update
   pi = pi_new;
   A = A_new;
   theta = theta_new;

   % evaluation
   Q(iter) = evaluation(pi,A,theta,gamma,xiSummed,mu);
   
   fprintf('Iteration %d: Q: %d \n',iter,Q(iter))
   if iter==1, continue; end
   
   converged = convergenceTest(Q(iter),Q(iter-1),epsilon);
end

Q(Q==0) = [];

% Model outputs
model.gamma = gamma;
model.xiSummed = xiSummed;
model.pi = pi;
model.A = A;
model.theta = theta;
model.alpha = alpha;
model.beta = beta;
model.Pb_mat = Pb_mat;
model.Q = Q;

if iter==max_iter
   warning(['Maximum iteration reached: ' num2str(iter)]);
   return;
end
fprintf('Convergence reached at iteration %d \n',iter)

end

