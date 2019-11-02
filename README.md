# BiMMy

BiMMyは、日本各地の「おいしいもの」を投稿して共有するためのサイトです。  
投稿者のリアルな情報を得られることで、旅先でのグルメ選びに役立ちます。   

![39f780bf3f0893591cafe9dfcc374edf](https://user-images.githubusercontent.com/50498102/67700338-2124b880-f9f1-11e9-9628-badf2e12faf3.jpg)


## サイトURL
https://mysterious-sands-64106.herokuapp.com

## 主な機能

1.ユーザー登録機能  
2.ログイン機能  
3.プロフィール編集機能  
4.画像投稿機能(S3)  
5.いいね機能(ajax)  
6.ページネーション機能  
7.星評価機能  
8.県名検索機能  
9.MAP表示機能(Google API)  
10.Twitterアカウントでのログイン機能  

## 注目して欲しい点
・dockerで開発環境を構築している点  
・CircleCIで自動でのテストとデプロイを実装している点  
・実践を意識して、ブランチを切って開発をしている点  
・GCPでマップ機能を実装している点  
・いいね機能をajax化している点  
・Twitterのapiを使用している点  

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
