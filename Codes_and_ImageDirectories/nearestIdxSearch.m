function ans_idx = nearestIdxSearch(DB, data)
    n = height(DB);
    data = repmat(data, n, 1);          % DBにサイズ合わせる
    % 差の二乗の総和(行方向)の平方根
    distances = sqrt(sum(((DB-data).^2)'));
    
    [s idx] = sort(distances);  % ソート
    ans_idx = idx;           % 答え
end

function bofVec = mkbofVector(CB, Img)
    % 空のベクトル用意
    bofVec = zeros(1, height(CB));
    % SURF特徴抽出
    I = rgb2gray(Img);
    p = detectSURFFeatures(I);
    [f, p2] = extractFeatures(I, p);
    
    % forループで投票
    for i=1:size(p2, 1)
        index = fromq1_7_idxSearch(CB ,f(i,:));
        index = index(1);   % 最も似ているもの
        bofVec(index) = bofVec(index)+1;
    end
    bofVec = bofVec ./ sum(bofVec, 2);  % 正規化
end