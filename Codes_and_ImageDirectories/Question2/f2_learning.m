function f2_learning(net, layer)
    % 画像データ群の名前
    pizza25 = 'dir2imgList_pizza25.mat';
    pizza50 = 'dir2imgList_pizza50.mat';
    negs = 'dir2imgList_negatives.mat';

    % 作成した画像データ群読み込み
    load(pizza25);
    list_p25 = imgList;
    load(pizza50);
    list_p50 = imgList;
    load(negs);
    list_negs = imgList;
    
    % DCNN特徴量抽出
    % net, layerの値はf2_learningとexecを実行する際統一させるために引数で設定するものにした。
    % net = vgg16;
    % layer = 'fc7';
    DCNNs_pizza25 = dcnns(list_p25, net, layer);
    DCNNs_pizza50 = dcnns(list_p50, net, layer);
    DCNNs_negatives = dcnns(list_negs, net, layer);
    
    % モデルづくり
    % n=25
    [datas, labels] = createLearningSet(DCNNs_pizza25, DCNNs_negatives);
    model_pizza25 = fitcsvm(datas, labels, 'KernelFunction', 'linear');
    
    % n=50
    [datas, labels] = createLearningSet(DCNNs_pizza50, DCNNs_negatives);
    model_pizza50 = fitcsvm(datas, labels, 'KernelFunction', 'linear');
    % セーブ
    save('f2learning_result.mat', 'model_pizza25', 'model_pizza50');
end

function shuffled = shuffleList(list)
    ir = randperm(width(list));
    list = {list{ir}};
end

function [datas, labels] = createLearningSet(positive, negative)
    % 横ベクトルを1画像のデータとするデータ群から、データを結合しラベルを作成して返す関数。
    labels = [ones(height(positive), 1); -ones(height(negative), 1)];
    datas = [positive; negative];
end