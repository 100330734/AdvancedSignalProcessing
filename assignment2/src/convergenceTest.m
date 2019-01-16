function converged = convergenceTest(Q_new,Q,epsilon)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
converged = false;
diff = abs(Q_new - Q);
if diff<epsilon, converged = true; end

end

