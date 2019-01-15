function [] = visualize_theta(theta,k,MAP)

figure
imagesc(theta)
colormap(gray)
if MAP
    title('$\theta$' + sprintf(' matrix. %d topics. MAP inference.',k), 'Interpreter', 'latex')
    xlabel('Probability','Interpreter','latex')
    ylabel('Documents','Interpreter','latex')
    saveas(gcf,sprintf('./images/R_map_%d_topics.jpg',k))
else
    title('$\theta$' + sprintf(' matrix. %d topics. ML inference.',k), 'Interpreter', 'latex')
    xlabel('Probability','Interpreter','latex')
    ylabel('Documents','Interpreter','latex')
    saveas(gcf,sprintf('./images/R_ml_%d_topics.jpg',k))
end

end

