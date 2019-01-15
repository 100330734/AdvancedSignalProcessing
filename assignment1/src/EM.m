function [Q,pi,theta,r,labels] = EM(K,N,I,pi,theta,prior,mu,epsilon,max_iter,MAP)

iter = 0;
Q = zeros(1,max_iter);
converged  = false;

while ~converged && iter~=max_iter
      
   iter = iter + 1; 

   % expectation
   r = expectation(K,N,pi,theta,mu);
   
   % maximization
   [new_pi, new_theta] = maximization(K,N,I,r,mu,prior,MAP);  

   % update
   theta = new_theta;
   pi = new_pi;

   % evaluation
   Q(iter) = evaluation(pi,theta,prior,r,mu,MAP);
   
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

