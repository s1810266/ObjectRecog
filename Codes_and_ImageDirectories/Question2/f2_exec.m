function f2_exec()
    % 実行すればlearningからsortingまでやってくれる。
    
    % 設定
    net = vgg16;
    layer = 'fc7';
    
    f2_learning(net, layer);
    f2_sorting(net, layer);
end