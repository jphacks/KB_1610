# Smart Order
## 製品概要
### Order x Tech

**-わずらわしい注文をよりスマートに-**

「注文」を「テクノロジー」と掛け合わせてみました。

### 背景（製品開発のきっかけ、課題等）
今回の開発対象の構想にあたり、LINEBotの活用から検討を行いました。  
LINEBotに掛け合わせる身近な課題として、飲食店における「注文」に対する煩わしさが挙がりました。  
大学の近所の飲食店では、注文の際に声を掛けて呼ぶ必要があるが、なかなか反応してくれない。  
しかも、ホールでの接客を行う店員さんは1人のみ。他のお客さんに品物を運ぶのも忙しそう。  
注文する品物が決まっているのに、店員さんがなかなか捕まらない時間は、私たちにとっては無駄な時間。  
また、店員さんを呼んだのに私たちが注文を再検討し始めると、店員さんにとって無駄な時間になる。  
この2つの無駄な時間は、双方に不利益を生んでいる。  
私たちにとっては、お腹が空いている状況では１秒でも早く品物が出てきてほしい。  
お店側からすれば、お店の回転率が下がることは利益の減少に繋がる可能性がある。  
お店側の不利益の面から言えば、私たちが会計時に1人1人支払うのも時間の無駄を生んでいる。  
でも、後から自分たちで精算するのも面倒…  
こんな背景から、**「わずらわしい注文をスマートに」**ということで、今回のサービスを作ることになりました。  

### 製品説明（具体的な製品の説明）
サービスの使用の流れ  
1. 店を探すために、Smart Orderをグループに追加  
2. キーワードを入れて店舗を探す  
3. 店舗を選択してメニューカテゴリを開く  
4. メニュー一覧から食べたいものを選び、カートに追加する  
5. 入店したらカートの中を確認し、注文する  
6. 食事後に割り勘や精算を行う
7. 退店  

### 特長

####1. 特長1
Bot機能による対話型でのメニュー参照
####2. 特長2
グループでの利用に適した機能提供

### 解決出来ること
* 店員を待たずに注文できる
* 店舗に訪れる前にメニューを参照できる

### 今後の展望
現在はグループではそれぞれのユーザIDが取得できないため、このユーザIDが取得可能となった場合には、割り勘機能などの精算に関する実装を行う。  
また、Smart Orderに翻訳機能を搭載することで、東京五輪に向けた外国人対応も検討している。  
ビジネス面での展望としては、背景で述べたように、店の回転率の点から考えると、このSmart Orderによって利益を挙げることが期待できる。  
このことから、店舗でのSmart Orderの利用を数百円程度の月額課金制として考える。  
サービスの利用料金が低価格なため、従業員が少なく、注文に関わる無駄の影響を受けやすい中小規模の飲食店への普及が望めるのではないかと考える。  
このSmart Orderの特性上、Smart Orderの運営側では、サービスに登録している飲食店の全メニュー情報を得ることが可能となる。これは、既存の飲食店情報提供サービスよりも詳細な情報である。  
この情報を活かし、新たな情報提供サービスを展開できるのではないかと考える。
例えば、旅行者向けにその地域の中小規模の飲食店の紹介から、実際の店舗での注文、精算までをLINEで完結できるサービスも実現可能である。
このSmart Orderを軸として、外食における情報や金銭のフローの改革や、（地域の）中小規模飲食店の支援を行えるのではないかと考える。

### 注力したこと（こだわり等）
* 
* 

## 開発技術
### 活用した外部技術
Heroku
#### API・データ
* LINE messenger API
* 

#### フレームワーク・ライブラリ・モジュール
* Sinatra
* LINE module

#### デバイス
* 
* 

### 独自技術
#### 期間中に開発した独自機能・技術
* 独自で開発したものの内容をこちらに記載してください
* 特に力を入れた部分をファイルリンク、またはcommit_idを記載してください（任意）
