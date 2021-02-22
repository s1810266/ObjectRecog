function f_1(listDataNameA, listDataNameB)
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
    
    % データベース作成
    % mkHistDB: カラーヒストグラム
    DBA = mkHistDB(imgListA);
    DBB = mkHistDB(imgListB);
    
    % 総サイズ
    n = height(DBA);
    idx = [1:n];
    cv = 5;
    
    % 精度
    accuracy = [];
    
    for i=1:cv
        % データ分割
        trainA = DBA(find(mod(idx,cv)~=(i-1)),:);
        evalA = DBA(find(mod(idx,cv)==(i-1)),:);
        trainB = DBB(find(mod(idx,cv)~=(i-1)),:);
        evalB = DBB(find(mod(idx,cv)==(i-1)),:);
        
        train = [trainA; trainB];
        eval = [evalA; evalB];
        
        % ラベル作成
        m = height(trainA);
        trainLabel = [ones(m,1); -ones(m,1)];
        m = height(evalA);
        evalLabel = [ones(m,1); -ones(m,1)];
        
        % 学習
        model = fitcsvm(train, trainLabel, 'KernelFunction', 'linear');
        
        % 分類
        [plabel, ~] = predict(model, eval);
        ac = numel(find(evalLabel==plabel))/numel(evalLabel);
        accuracy = [accuracy ac];
    end
    % 精度表示
    fprintf("accuracy: %f\n", mean(accuracy));
    %accuracy
    
end