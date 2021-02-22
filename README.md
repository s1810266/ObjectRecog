# ObjectRecog

## ファイル説明
mファイルはレポートに記したのと同様のものである。
本ファイルでは各ディレクトリと.matファイルについて説明を行う。
尚課題2のネガティブ画像を格納したimgdir_negativesディレクトリとその中身はここにはアップロードを行っていない。

### 課題1 - ディレクトリ
- imgdir_misoSoup
- imgdir_noodle
- imgdir_number
- imgdir_yakisoba
上記4ディレクトリはそれぞれ「味噌汁」「noodle」「number」「ペヤング」を検索ワードとして、ORDERをrelevanceにした結果から100枚、ノイズを弾いて収集した結果を格納した。不足分は手動で画像を集め、縦横比を固定したまま最大320pxにリサイズしてデータに加えた。

### 課題1 - matファイル
- dir2imgList_result.mat
- dir2imgList_result_misoSoup.mat
- dir2imgList_result_noodle.mat
- dir2imgList_result_number.mat
- dir2imgList_result_yakisoba.mat
dir2imgList_result.matはdirectory2imglist.mの実行結果である。これを引数として読み込んだデータに合わせて名称変更したのが下4つの.matファイルである。


### 課題2 - ディレクトリ
- imgdir_pizza25
- imgdir_pizza50
- imgdir_pizza300latest
これらは「pizza」を検索ワードとして、上二つはrelevance、もう一つはlatestの順序で検索、収集した画像を格納したものである。

- f2sorting_result_n25
- f2sorting_result_n50
f2_exec.mを実行すると、これらのディレクトリが作られる。ディレクトリ内には「(順位)_(SVMスコア).png」の名でクエリの画像が格納されている。


### 課題2 - matファイル
- dir2imgList_pizza25.mat
- dir2imgList_pizza50.mat
- dir2imgList_pizza300latest.mat

directory2imglist.mの実行結果から、データに合わせて名称変更したものである。添付していないネガティブ画像1000枚のディレクトリからdir2imgList_negatives.matも作成したが、容量の関係で今回添付はしていない。

- f2learning_result.mat

f2_learning.mを実行した結果がこのファイル名で出力される。中には2種類の学習済みデータが格納されている。
