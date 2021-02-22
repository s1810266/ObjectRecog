function directory2imglist(directoryName)
    % 
    d = dir(directoryName);
    size(dir(directoryName));
    
    % ファイル名のリストを作成
    names = {};
    % i=1, 2は非画像ファイル(同一ディレクトリ、親ディレクトリ)
    for i=3:length(d)
        names = {names{:} d(i).name};
    end
    
    % 画像リスト作成
    imgList = {};
    for i=1:length(names)
        imgList = {imgList{:} imread(names{i})};
    end
    
    save('dir2imgList_result.mat', 'imgList');
    
end