function Pb = calculatePbmat(mu,theta)

% % mu: TxI
% % theta: KxI
% % Output: P_b = TxK
% 
% Pb = mu*log(theta'+eps);
% Pb = exp(Pb);
% % 
% % Clipping and normalization
% Pb(Pb==0) = realmin;
% Pb = Pb./sum(Pb,2);


% mu: TxI
% theta: KxI
% Output: P_b = KxT

Pb = log(theta+eps)*mu';
Pb = exp(Pb);

% Clipping and normalization
Pb(Pb==0) = realmin;
Pb = Pb./sum(Pb,1);

end

