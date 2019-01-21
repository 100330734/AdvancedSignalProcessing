function [states_FB, states_Vit] = compareFBvsViterbi(model)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

states_FB = FB_decoder(model.gamma);
states_Vit = viterbi_decoder(model.pi, model.A,model.Pb_mat);

[N, T] = size(states_FB);
K = size(model.pi,1);
%Plotting

% fullfig
figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.97]);
for i = 1 : N
    s(i) = subplot(5,2,i); % extra row for placing legend beautifully
    plot(states_FB(i,:));   
    axis([0 T 1 K])
    hold on
    plot(states_Vit(i,:),'r--');  
    xlabel('Documents','Interpreter','latex')
    ylabel(s(i),sprintf('Sequence %d',i), 'Interpreter', 'latex')
    hold off
end

% Construct a Legend with the data from the sub-plots
hL = legend('FB MAP decoder', 'Viterbi decoder','Location','southwestoutside');
newPosition = [0.5055 0.9 0.01 0.01];
% newUnits = 'normalized';
set(hL,'Position', newPosition);

% legend('FB MAP decoder', 'Viterbi decoder','Location','southwestoutside');
sgtitle('Comparison FB vs Viterbi decoder','Interpreter','latex')
saveas(gcf,sprintf('./images/comparison_FB_Viterbi_K_%d.jpg',K))
close 

end

