% 第六回演習で作成したもの。
% 若干内容を変更し、dataには画像データのパスではなく画像データ本体を指定する。
% data: 画像ファイル名のセル配列
% net: alexnetなど
% layer: 'fc7'など
function DCNNs = dcnns (data, net, layer)
    DCNNs = [];    
    n = width(data);
    for i=1:n
        img = data{i};
        reimg = imresize(img, net.Layers(1).InputSize(1:2));
        
        % netのlayerより特徴抽出
        dcnnf = activations(net, reimg, layer);
        
        % ベクトル化
        dcnnf = squeeze(dcnnf);
        
        % 正規化
        dcnnf = dcnnf/norm(dcnnf);
        
        % 保存
        DCNNs = [DCNNs; dcnnf'];    % 転置して格納
    end
end