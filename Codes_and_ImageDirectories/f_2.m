% k:クラスター数。500程度が目安
% listDataNameXX: それぞれのimgListの格納したデータファイル名
function f_2(listDataNameA, listDataNameB, k)
    % 作成した画像データ群読み込み
    %load('dir2imgList_result_noodle.mat');
    load(listDataNameA);
    imgListA = imgList;
    %load('dir2imgList_result_yakisoba.mat');
    load(listDataNameB);
    imgListB = imgList;
    
    % リストシャッフル
    ir = randperm(width(imgListA));
    imgListA = {imgListA{ir}};
    ir = randperm(width(imgListB));
    imgListB = {imgListB{ir}};
    
    imgList = {imgListA{:} imgListB{:}};
    
    % コードブック作成
    % k = 500;
    %CB = mkCodeBook(imgList, k);
    CB = mk_codebook(imgList);
    
    % データベース作成
    n = width(imgListA);
    bofA = [];
    for j=1:n
        %bofA = [bofA; mkbofVectorNorm(CB, imgList{j})];
    end
    n = width(imgListB);
    %k = height(CBB);
    bofB = [];
    for j=1:n
        %bofB = [bofB; mkbofVectorNorm(CB, imgList{j})];
    end
    bofA = mk_code(CB, imgListA);
    bofB = mk_code(CB, imgListB);
    
    % 分類
    n = height(bofA);
    idx = [1:n];
    cv = 5;
    
    accuracy = [];
    
    for i=1:cv
        % データ分割
        trainA = bofA(find(mod(idx,cv)~=(i-1)),:);
        evalA = bofA(find(mod(idx,cv)==(i-1)),:);
        trainB = bofB(find(mod(idx,cv)~=(i-1)),:);
        evalB = bofB(find(mod(idx,cv)==(i-1)),:);
        
        train = [trainA; trainB];
        eval = [evalA; evalB];
        
        % ラベル作成
        m = height(trainA);
        trainLabel = [ones(m,1); -ones(m,1)];
        m = height(evalA);
        evalLabel = [ones(m,1); -ones(m,1)];
        
        % 学習
        model = fitcsvm(train, trainLabel, 'KernelFunction', 'rbf', 'KernelScale', 'auto');
        
        % 分類
        [plabel, ~] = predict(model, eval);
        ac = numel(find(evalLabel==plabel))/numel(evalLabel);
        accuracy = [accuracy ac];
    end
    % 正規化と精度表示
    fprintf("accuracy: %f\n", mean(accuracy));
    % accuracy
end
function CB = mkCodeBook(imgList, k)
    Features = [];
    for i=1:length(imgList)
        I = rgb2gray(imgList{i});
        p = detectSURFFeatures(I);
        [f, p2] = extractFeatures(I, p);
        Features = [Features; f];
    end
    if size(Features)>50000
        Features = Features(randperm(size(randperm,1),50000),:);
    end
    [index, centers] = kmeans(Features, k, 'MaxIter', 3000);
    CB = centers;
end

function bofVec = mkbofVector(CB, Img)  % 正規化せず
    % 空のベクトル用意
    bofVec = zeros(1, height(CB));
    % SURF特徴抽出
    I = rgb2gray(Img);
    p = detectSURFFeatures(I);
    [f, p2] = extractFeatures(I, p);
    
    % forループで投票
    for i=1:size(p2, 1)
        % データベース:CB
        % 調べるdata: Features?
        index = nearestIdxSearch(CB ,f(i,:));
        index = index(1);   % 最も似ているもの
        bofVec(index) = bofVec(index)+1;
    end
end
function bofVec = mkbofVectorNorm(CB, Img)
    bofVec = zeros(1, height(CB));      % ベクトル用意
    bofVec = mkbofVector(CB, Img);      % 非正規化で作成
    bofVec = bofVec ./ sum(bofVec, 2);  % 正規化
end