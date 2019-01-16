function [] = create_wordcloud(K,dictionary,mu,labels,MAP)
%CREATE_WORDCLPUD This function generates a wordcloud plot per topic to
%show the most frequent words per topic.
% INPUTS:
%   K: Number of topics.
%   dictionary: Dictionary containing the words.
%   mu(NxK): Number of times a word from the dictionary appears in each
%   documents.
%   labels: Topic assignatio for each document.

% 1. Obtain most frequent word per document
[freq_word_doc,idx_word_doc] = max(mu,[],2);
words_doc = dictionary(idx_word_doc);

r = numSubplots(K);
for k = 1:K
    % Create cell array with the most frequent word per topic
    words_topic = words_doc(labels==k);
    
    subplot(r(1),r(2),k)
    % Create categorical data and plot wordcloud
    wordcloud(categorical(words_topic))
    title(sprintf('Topic: %d',k))
end
if MAP
    saveas(gcf,sprintf('./images/MAP/wordcloud_MAP%d_topics.jpg',K))
else
    saveas(gcf,sprintf('./images/ML/wordcloud_ML%d_topics.jpg',K))
end

% r = numSubplots(K);
% for k = 1:K
%     
%     % 1. Obtain the most frequent words shared between documents in a topic
%     mu_k_topic = mu(labels==k,:);
%     freq_word_doc= sum(mu_k_topic,1);
%     % prob_word_topic = frequency_word_topic/sum(frequency_word_topic);
%     % bar(prob_word_topic);
%     
%     % 2. Choose most frequent words w.r.t threshold:
%     percent = 1;
%     th = ceil(max(freq_word_doc)-max(freq_word_doc)*percent);
%     idx = freq_word_doc>50;
%     freq_words_topic  = dictionary(idx');
%     
%     % 4. Plot word cloud
%     subplot(r(1),r(2),k)
%     wordcloud(categorical(freq_words_topic));
%     title(sprintf('Topic: %d',k))
% end
% saveas(gcf,sprintf('./images/word_cloud%d_topics.jpg',K))


end

