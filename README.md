# README

### タイトル
## 「wonderful_editor」
『Qiita風記事作成アプリ』 
<img width="1253" alt="スクリーンショット 2022-05-09 19 30 39" src="https://user-images.githubusercontent.com/94003691/167786245-927a0f05-cb3a-4d38-b159-121fe9508848.png">

## 概要
記事を作成し、共有するアプリ

## URL・テストアカウント

- ポートフォリオURL : https://wonderful-editor-f.herokuapp.com/
- アカウント : ゲスト
- email : guest@example.com
- password : guest123


## 制作意図
「実務を見据えたスキル学習」を意識し、制作しました。 転職前に、「試行錯誤する力」「わからないことを調べる力」「適切な質問ができる力」という自走力を磨くために注力してきました。 具体的には「学習段階では知らない概念や言葉が含まれているような指示をもとに、アプリを作る経験」がそれにあたります。基礎的な学習は行いましたが実務で知らないことが出た際、どの様に解決を図っていくのか、このポートフォリオ作成を通してその練習をしました。 なので、このポートフォリオは私が実際に作って世に出したいというようなアプリではありません。そういったアプリは実務を通し、スキルアップを図りながら作った方がより深い学習にもなると考えているからです。 ここまでの学習は「「実務を見据えた学習」」であるため、今回のポートフォリオについてもその一環です。

## 使用技術
- Ruby 2.7.4
- Ruby on Rails 6.0.4.4
- Postgres
- Docker
- Rspec

## 機能一覧
- 記事一覧（トップページ）
- マイページ（自分が書いた記事の一覧）


https://user-images.githubusercontent.com/94003691/167798456-1a0d0301-98fe-4291-bd35-5c654fa9e700.mov



- ユーザー登録・サインイン/サインアウト
<img width="1267" alt="スクリーンショット 2022-05-09 19 05 10" src="https://user-images.githubusercontent.com/94003691/167785634-297986a1-a4eb-413e-a025-165d74d2d0c7.png">

- 記事のCRUD（一覧以外）
- 記事の下書き機能


https://user-images.githubusercontent.com/94003691/167808085-767d5852-a60b-4279-8575-cad19c2077e4.mov

## テスト
- Rspce
  - 単体テスト（Model）
  - 結合テスト（Request）

## ER図

![wonderful editer](https://user-images.githubusercontent.com/94003691/167808631-e9027ab3-5189-4cd1-b3b2-7130f1f51be1.png)
