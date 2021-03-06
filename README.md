作成者：阿河智浩\
作成日：2021年10月18日
# アプリ概要
## ファイル構成
このアプリは以下のようなフローで構成されています
* パラメータの設定(App\Program\parameter.m)
* 計算(App\Program\calculate.m)
* 出力(App\Program\output.m)
つまり，パラーメータを設定し，計算出力までを統括して行うアプリです．\

それに加えて計算式がわかりやすいようにTexファイルで計算式を出力しています．それを参照しながら実行を変更してみてください．

# 使い方とオプション


# ファイルの内容
## parameter.m
- このファイルではパラメータを設定しています．\
初期パラメータは以下の形で設定されています．

| パラメータ|意味|行×列|初期値|
|:--|:--|:--:|:--:|
|t|時間|1×1|1|
|m|アグリゲータの入札ブロック数|1×1|10|
|o|発電業者の入札ブロック数|1×1|10|
|n|負荷の入札ブロック数|1×1|10|
|N|需要家の人数|1×1|1000|
|pv|PV発電機数|1×1|1|
|l|ノード数|1×1|3|
|M|bigMの範囲数|1×1|10e30|

以上のパラメータを用いて特定のパラメータを生成します．生成する際に使用する関数は以下です．
- パラメータ設定関数(App\Program\functions\parameter)

| 関数名|引数1|引数2|引数3|引数4|初期値|
|:--|:--|:--|:--|:--|:--|
|pdr|時間|SIZE|上限値||pdr(t,N,0.02)|
|lambdaG|SIZE|ステップ幅|||lambdaG(n,2)
|lambdaD|SIZE|初期値|ステップ幅||lambdaD(n,19,1)|
|pa|SIZE|pdr値|||pa(m, pdr_1)|
|pg|SIZE|初期値|ステップ幅||pg(o,1,1.5)|
|pd|SIZE|初期値|ステップ幅||lambdaD(n,30,3)|
|cdr|時間|lambda値|SIZE|ステップ幅|cdr(t,lambdaG_1,N,10)|

- 注意点1\
pdr,cdrに関してはt次元を考慮した上で関数を制作しているがその他に関してはforループでt次元に拡張しているため今後の研究においては再度作成する必要がある．
- 注意点2\
paに関してはpdr値を用いるためpdrがpaの生成より早くないといけない．同様の理由でcdrとlambdaGにも同様の関係がある．

生成されたパラメータは.matフォーマットで以下の形で保存されます．
|ファイル名|値|保存されるパラメータ|初期値|
|:--|:--|:--|:--|
|params.mat|初期パラメータ|m,o,n,N,M,pv,l,t|10,10,10,1000,1,3,1|
|Bs.mat|ノード間サセプタンス[S]|Bs|[100,125,150]|
|fmax.mat|ノード間送電容量[MW]|fmax_1,fmax_2,fmx_3|1,2,2|
|ppv.mat|風力発電上限値|ppv_1,ppv_2,ppv_3|0,0,0|
|pa.mat|アグリゲータのノードuにおけるブロックmの入札量[kWh]|pa_1,pa_2,pa_3|別紙参照|
|pg.mat|ノードuにおける発電業者のブロックoの入札量[kWh]|pg_1,pg_2,pg_3|別紙参照|
|pd.mat|ノードuにおける需要のブロックnの入札量[kWh]|pd_1,pd_2,pd_3|別紙参照|
|cdr.mat|需要家iの調達費用[JPY/kWh]|cdr_1,cdr_2,cdr_3|別紙参照|
|pdr.mat|シナリオにおけるノードuの需要家iの調達量限界値[kWh]|pdr_1,pdr_2,pdr_3|別紙参照|
|lambdaG.mat|ノードuにおける発電業者のブロックo入札価格[JPY/kWh]|lambdaG_1,lambdaG_2,lambdaG_3|別紙参照|
|lambdaD.mat|ノードuにおける需要のブロックnの入札価格[JPY/kWh]|lambdaD_1,lambdaD_2,plambdaD_3|別紙参照|

設定されたパラメータは実行時間を取得する関数getTime関数によって自動的にファイル化され保存されます．\
＊保存先はApp\Datas\Parameter

## calculate.m
* このファイルではparameter.mで保存されたパラメータを用いて実際にGurobiを用いて計算を行う．
* 実行する関数に関してはApp\Formulaファイル内にて記載しているため参照してほしい．
### データの取得　App\Program\functions\getDatas.m
- データの取得に関してはgetDatas関数を用いて取得を行います．以下の4つのパスを用いてデータの取得から実行結果の保存までを統括して行います．

|パス名|意味|PASS|
|:--|:--|:--|
|CAL_PASS|計算を行う場所calculate.mのPASS|App\Program\functions\calculate|
|GET_PASS|取得するパラメータのフォルダ|App\Datas\Params|
|SAVE_PASS|実行結果を保存するためのパス|App\Datas\Results|
|GETDATA_PASS|実際に使用するパラメータのファイルパス|App\Datas\Params\パラメータのフォルダ名|

* GETDATA_PASSに関してはgetDatas関数を通してから得られるパス
* GETDATA_PASSを用いてデータをロードする．

### 列の展開　App/Program/functions/calculate/coordinates1.m,coordinates3.m
* 目的関数は決定変数によって構成されている．まずは列を設定することによってどこに値を入れればいいのかを探ることができる．
* 取得する値に関しては列の先頭とサイズの値である．
* coordinates1とcoordinates3の違いは引数が1か3の違い．



## output.m
## 関数の内容
