% listDataNameXX: それぞれのimgListの格納したデータファイル名
function f_3(listDataNameA, listDataNameB)
    % 作成した画像データ群読み込み
    load(listDataNameA);
    imgListA = imgList;
    load(listDataNameB);
    imgListB = imgList;
    % リストシャッフル
    ir = randperm(width(imgListA));
    imgListA = {imgListA{ir}};
    ir = randperm(width(imgListB));
    imgListB = {imgListB{ir}};
    
    % DCNN特徴量抽出
    net = alexnet;
    layer = 'fc7';
    
    DCNNs = dcnns({imgListA{:} imgListB{:}}, net, layer);
    
    %DCNNsA = dcnns(imgListA, net, layer);
    %DCNNsB = dcnns(imgListB, net, layer);
    DCNNsA = DCNNs([1:width(imgListA)], :);
    DCNNsB = DCNNs([1+width(imgListA):width(imgListA)*2], :);
    
    % 分類
    n = height(DCNNsA);
    idx = [1:n];
    cv = 5;
    
    accuracy = [];
    
    for i=1:cv
        % データ分割
        trainA = DCNNsA(find(mod(idx,cv)~=(i-1)),:);
        evalA = DCNNsA(find(mod(idx,cv)==(i-1)),:);
        trainB = DCNNsB(find(mod(idx,cv)~=(i-1)),:);
        evalB = DCNNsB(find(mod(idx,cv)==(i-1)),:);
        
        train = [trainA; trainB];
        eval = [evalA; evalB];
        
        % ラベル作成
        m = height(trainA);
        trainLabel = [ones(m,1); -ones(m,1)];
        m = height(evalA);
        evalLabel = [ones(m,1); -ones(m,1)];
        
        
        
        % 学習
        %model = fitcsvm(train, trainLabel, 'KernelFunction', 'rbf', 'KernelScale', 'auto');
        model = fitcsvm(train, trainLabel, 'KernelFunction', 'linear');
        
        % 分類
        [plabel, ~] = predict(model, eval);
        ac = numel(find(evalLabel==plabel))/numel(evalLabel);
        accuracy = [accuracy ac];
    end
    % 正規化と精度表示
    fprintf("accuracy: %f\n", mean(accuracy));
    accuracy;
end

