# Easy Daily Report

日報を運用するためのWebアプリケーションです。Ruby on Railsで構築しています。

## 何が出来るのか

簡単な日報運用が出来ます。企業内で複数人で使うような想定です。  
日報毎にプロジェクトにどれだけの時間を使ったのかや、疑問点、感想を記入できます。

## 必要な環境

- Ruby2.2.2+
- MySQL5.5+
- nginx + unicorn

上記いずれも手元で動かした環境です。Gemfileいじったりすれば色々変更できると思います。また、設定をするにあたり多少Railsの知識を持っていることが求められます。

## インストール

### 基本設定

git cloneで持ってきて、まずは以下のファイルの設定を作成してください。

- config/database.yml  
database.yml.sampleをベースに、手元の環境に合った内容に作成してください
- config/application.yml  
application.yml.sampleをコピーしてください

### メール設定

日報を投稿する時にメールを送信することが可能です。その際は下記の設定をしてください。送信しない場合は次の「上記設定が終わったら」に進んでください。

- config/application.yml  
主に'PLEASE FILL'と書かれた内容を編集してください
 - host： トップページのURLを記入してください、メールを送信する時に利用します
 - mailのis_send： メールを送るか送らないかのフラグです。trueに変更してください
 - mailのfrom： 日報のメール送信元アドレスです。虚偽の情報を入れるとスパム扱いされることがありますので、正しい情報を入力してください
 - mailのto： メールの送信先です。MLのアドレスを指定すると便利です
- config/environments/production.rb  
RailsのActionMailerのための設定が必要です。Gmailを用いる場合は
```
 （http://railsguides.jp/action_mailer_basics.htmより引用）

 config.action_mailer.delivery_method = :smtp
 config.action_mailer.smtp_settings = {
   address:              'smtp.gmail.com',
   port:                 587,
   domain:               'example.com',
   user_name:            '<ユーザー名>',
   password:             '<パスワード>',
   authentication:       'plain',
   enable_starttls_auto: true  }
```
このような設定を記入する必要があります。  
[こちらのサイト](http://railsguides.jp/action_mailer_basics.html#action-mailer%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)により詳細な説明があります。

### 上記設定が終わったら

以下を実行してください。

- gem install bundler
- bundle install
- rake db:migrate
- rake db:seed

後はunicornを動かせばokです。

## 使い方

### 最初の使い方

まずseedでダミーの管理者を作っていますので、そのアカウントでログインしてください。

- メールアドレス： admin@example.com
- パスワード： admin123

上記情報でログイン可能です。  
ログイン後にメニューの「ユーザ」から新規登録をしてユーザを追加したり、「顧客」から顧客の追加、「プロジェクト」からプロジェクトの追加をしてください。  
**※日報の投稿にはプロジェクトが必須です。プロジェクトの登録には顧客が必須です。**

### ユーザの種類について

- 管理者： 全ての操作が可能です
- メンバー： ユーザを追加する以外の全ての操作が可能です
- パートナー： 日報を投稿することのみ可能です、他人の日報を見ることも出来ません

## 今後の予定

### 実装について

テストが未着手なのでそっちを整備したり、追加したい機能等色々ありますが、これが実際使われるのかどうか、要望があるかどうかで決めていきたいと思います。予定は未定。

### バグ等について

全部私が手動で見てるだけなので、何かしらバグが含まれている可能性が多分にあります。issueやTwitter等でお知らせいただけると助かります。

## ライセンス

MIT license. Copyright (c) 2016 [shibuso](http://shibuso.net)
