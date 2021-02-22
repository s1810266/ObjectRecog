function DB = mkHistDB(imglist)
    % データベースを作成
    % 第二回練習問題7より
    DB = [];
    for i=1:length(imglist)
        % 第二回、これまでの流れを参考にヒストグラムを作成
        X = imglist{i};
        R = X(:,:,1); G = X(:,:,2); B = X(:,:,3);
        X64 = floor(double(R)/64)*4*4 + floor(double(G)/64)*4 + floor(double(B)/64);
        X64_vec = histc(double(reshape(X64,1,numel(X64))), [0:63]);
        h = histc(double(X64_vec), [0:63]);
        h = h/sum(h);
        
        % データベースに追加
        DB = [DB; h];
    end
end