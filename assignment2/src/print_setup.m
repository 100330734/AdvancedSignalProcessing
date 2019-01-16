function [outputArg1,outputArg2] = print_setup(MAP,max_iter,n_init,epsilon)

fprintf('Running EM algorithm. \n')
fprintf('SET-UP \n')
fprintf('------------------------------- \n');
if MAP ,fprintf('Inference: MAP\n');
else fprintf('Inference: ML\n');
end
fprintf('Max. Number of EM iterations: %d \n',max_iter);
fprintf('Number of Initializations: %d \n',n_init);
fprintf('Convergence Tolerance Values: %d \n',epsilon);

end

