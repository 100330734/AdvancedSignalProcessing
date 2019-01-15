function [] = visualize_R(R,k,MAP)

figure
imagesc(R)
colormap(gray)
colorbar
xticks(1:k)
labels = string(1:k);
xticklabels(labels);
if MAP
    title(sprintf('R matrix. %d topics. MAP inference.',k),'Interpreter','latex')
    xlabel('Topic','Interpreter','latex')
    ylabel('Documents','Interpreter','latex')
    saveas(gcf,sprintf('./images/MAP/R_map_%d_topics.jpg',k))
else
    title(sprintf('R matrix. %d topics. ML inference.',k),'Interpreter','latex')
    xlabel('Topic','Interpreter','latex')
    ylabel('Documents','Interpreter','latex')
    saveas(gcf,sprintf('./images/ML/R_ml_%d_topics.jpg',k))
end

end

