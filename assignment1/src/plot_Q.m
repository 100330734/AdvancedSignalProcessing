function [outputArg1,outputArg2] = plot_Q(Q,K,MAP)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

figure
plot(Q,'LineWidth',2)
xlabel('Number of EM iterations','Interpreter','latex');

if MAP
    title(['Number of Topics: ',num2str(K),'. MAP Inference'], 'Interpreter','latex');
    saveas(gcf,sprintf('./images/MAP/Q_map_%d_topics.jpg',K))
else
    title(['Number of Topics: ',num2str(K),'. ML Inference'], 'Interpreter','latex');
    saveas(gcf,sprintf('./images/ML/Q_ml_%d_topics.jpg',K))

end

end

