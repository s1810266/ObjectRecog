function f_1Kai()
    load('dir2imgList_result_noodle.mat');
    imgListA = imgList;
    load('dir2imgList_result_yakisoba.mat');
    imgListB = imgList;
    
    %  DB作成
    DBA = mkHistDB(imgListA);
    DBB = mkHistDB(imgListB);
    
    % サイズ
    n = height(DBA);
    idx = [1:n];
    
    % XX-fold
    cv = 5;
    
    % 精度
    accuracy = [];
    
    for i=1:cv
        % 分割
        refA = DBA(find(mod(idx, cv)~=(i-1)), :);
        testA = DBA(find(mod(idx, cv)==(i-1)), :);
        refB = DBB(find(mod(idx, cv)~=(i-1)), :);
        testB = DBB(find(mod(idx, cv)==(i-1)), :);
                
        % 統合
        refs = [refA; refB];
        tests = [testA; testB];
        
        % 設定
        border_ref = 80;
        border_test = 20;
        
        correct = 0;
        
        % NN計算と精度計算
        for j=1:height(tests)
            nearest = nearestIdxSearch(refs, tests(j, :));
            
            tag_test = 0;
            tag_reference = 0;
            
            % 各々後半ならば1にする
            if j > border_test
                tag_test = 1;
            end
            if nearest(1) > border_ref
                tag_reference = 1;
            end
            
            if tag_test == tag_reference
                correct = correct + 1;
            end
        end
        ac = (correct * 1.0) / height(tests);
        accuracy = [accuracy ac];
    end
    fprintf("accuracy: %f\n", mean(accuracy));
end