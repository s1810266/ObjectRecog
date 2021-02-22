function f2_sorting(net, layer)
    % 画像データ群の名前
    query = 'dir2imgList_pizza300latest.mat';
    
    % 作成した画像データ群読み込み
    load(query);
    list_query = imgList;
    
    % 学習結果読み込み
    load('f2learning_result.mat');
    
    % DCNN特徴量抽出
    DCNNs_query = dcnns(list_query, net, layer);
    
    % n=25
    % 予測
    [idx, score] = mkRanking(model_pizza25, DCNNs_query);
    % 出力
    outputImgs('f2sorting_result_n25', idx, score, list_query);
    
    % n=50
    % 予測
    [idx, score] = mkRanking(model_pizza50, DCNNs_query);
    % 出力
    outputImgs('f2sorting_result_n50', idx, score, list_query);
    
end

function [sorted_idx, sorted_score] = mkRanking(model, data)
    % predict
    [~, score] = predict(model, data);
    % sort
    [sorted_score, sorted_idx] = sort(score(:,2), 'descend');
end

function outputImgs(directoryName, sorted_idx, sorted_score, imgList)
    % 順位をつけて、スコア情報もファイル名に含めて画像群を出力。
    % directoryNameが出力先ディレクトリ
    mkdir(directoryName);
    for i=1:numel(sorted_idx)
        fileName = strcat(directoryName, '/', num2str(i), '_', num2str(sorted_score(i)), '.png');
        imwrite(imgList{sorted_idx(i)}, fileName);
    end
end