% 解答例のk_codebookを少し改造。
% 引数に画像データのリストをセット。
function codebook=mk_codebook(tlist)
 
  k=1000;
 
  % 200枚の画像からSURF特徴をdetectSURFFeaturesとextractFeaturesで抽出．
  features=[];
  for i=1:length(tlist)
    I=rgb2gray(tlist{i});
    %fprintf('reading [%d] %s\n',i,tlist{i});
    %pnt=detectSURFFeatures(I);
    pnt=createRandomPoints(I,1000);
    [fea,vpnt] = extractFeatures(I,pnt);
    features=[features; fea];
  end
 
  [index, codebook]=kmeans(features,k,'MaxIter',3000);
  size(codebook);
  % codebook を save します．
end