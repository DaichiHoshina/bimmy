# BiMMy

BiMMyは、日本各地の「おいしいもの」を投稿して共有するためのサイトです。  
投稿者のリアルな情報を得られることで、旅先でのグルメ選びに役立ちます。  
Laravelで作ったものが気に入ったので、railsでも作成しました。  

![b9f6b51f8410c1b4f8cf7d8de2f54451](https://user-images.githubusercontent.com/50498102/64840090-ddd6dc00-d634-11e9-958e-99e79d25769e.jpg)


## サイトURL
https://mysterious-sands-64106.herokuapp.com

## 主な機能

1.ユーザー登録機能  
2.ログイン機能  
3.プロフィール編集機能  
4.画像投稿機能(S3)  
5.いいね機能  
6.ページネーション機能  
7.星評価機能  
8.県名検索機能  
9.MAP表示機能(Google API)  

## 注目して欲しい点
・dockerで開発環境を構築していること  
・CircleCIで自動でのテストとデプロイを実装していること
・実践を意識して、ブランチを切って開発をしていること
・GCPでマップ機能を実装していること

## 使用技術
- 言語/フレームワーク
    - Ruby2.7 / Ruby on Rails 5.2
- 開発環境
    - Docker for Mac
    - Atom
- 本番環境
    - heroku
- 使用技術
    - CircleCI
    - GitHub
    - AWS
        - S3
    - GCP
        - Geocoding API
        - Maps JavaScript API
- コード整形
    - Rubocop
- テスト
    - Rspec

## 今後の課題
・herokuからAWSを使ったデプロイに切り替える。  
・テストの数が少ないので充実させていく。  
