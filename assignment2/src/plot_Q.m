function [] = plot_Q(Q,K)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

figure
plot(Q,'LineWidth',2)
xlabel('Number of EM iterations','Interpreter','latex');

title(['Number of Topics: ',num2str(K)], 'Interpreter','latex');
saveas(gcf,sprintf('./images/Q_%d_topics.jpg',K))

end

