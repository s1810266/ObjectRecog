% 第六回で作成したq6_xxFoldCrossValidationを流用。
% 基本的に変更点は無いが、data_XXXには画像ファイル名群ではなく画像ファイルそのもののデータ群を用いる。

% data_pos, data_negは同じ数だけあると仮定
% net: alexnetなど
% layer: 'fc7'など
% type: 'linear' 'rbf'など
% cv: 5など(XX-fold cross vallidation)
function xxFoldCrossValidationWithNet (net, layer, type, cv, data_pos, data_neg)
    n = width(data_pos);
    idx = [1:n];
    accuracy = [];
    
    % 下準備
    DCNNs_pos = dcnns(data_pos, net, layer);
    DCNNs_neg = dcnns(data_neg, net, layer);
    
    % それぞれ(画像枚数)×(layerの次元数)
    size(DCNNs_pos);
    size(DCNNs_neg);
    
    for i=1:cv
        train_pos=DCNNs_pos(find(mod(idx,cv)~=(i-1)),:);
        eval_pos =DCNNs_pos(find(mod(idx,cv)==(i-1)),:);
        train_neg=DCNNs_neg(find(mod(idx,cv)~=(i-1)),:);
        eval_neg =DCNNs_neg(find(mod(idx,cv)==(i-1)),:);
        
        train = [train_pos; train_neg];
        eval = [eval_pos; eval_neg];
        
        label_train = [ones(height(train_pos),1); -ones(height(train_neg),1)];
        label_eval = [ones(height(eval_pos),1); -ones(height(eval_neg),1)];
        
        % 学習
        model = q6_1_learn(train, label_train);
        
        % 分類
        plabel = predict(model, eval);
        
        % 評価
        ac = numel(find(label_eval==plabel))/numel(label_eval);
        accuracy = [accuracy ac];
        
    end
    accuracy;
    fprintf("accuracy: %f\n", mean(accuracy));
    
end
