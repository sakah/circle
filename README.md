Jenkinsの復習
============

参考にしたページ
--------

[Jenkins入門 - Rubyプログラマー向け連載](http://www.buildinsider.net/enterprise/jenkins)

MacにJenkinsをインストール
----------------------
```Bash
$ brew install jenkins
```

Jenkinsの起動
------------
```java
$ java -jar /usr/local/opt/jenkins/libexec/jenkins.war
```
`http://localhost:8000`で見える。

プラグインのインストール
-------------------
Jenkinsの管理 -> プラグインの管理

- GIT plugin
- rbenv plugin
- Growl Plugin : 通知用
- Parameterized Trigger plugin　: 次に実行したいプロジェクトを登録できる。
- Build Pileline Plugin : 一連のビルドを見やすくするもの。


ビルド環境
--------
rbenv_build_wrapper

```sh
The Ruby version -> 2.1.2
Preinstall gem list -> bundler,rake
RBENV_ROOT -> $HOME/.rbenv-jenkins
rbenv.git -> https://github.com/sstephenson/rbenv.git
```

**RBENV_ROOTの変更が重要!**

ビルド 
-----

シェルの実行（単体テスト用）

```sh
rbenv exec bundle install --path vendor/bundle
bundle exec rake db:migrate
bundle exec rake db:test:clone
bundle exec rspec spec/*/*_spec.rb
````

シェルの実行（結合テスト用）

```sh
rbenv exec bundle install --path vendor/bundle
bundle exec rake db:migrate
bundle exec rake db:test:clone
bundle exec rspec spec/*/*.feature
````

シェルの実行（デプロイテスト用）

```sh
if ! git ls-remote heroku; then
  git remote add heroku git@heroku.com:afternoon-meadow-1725.git
fi
git push heroku master # HerokuへチェックアウトしたソースをPushする。
heroku run rake db:migrate # Heroku上のDBのスキーマ情報を更新する。

````

注意点
-----

- Herokuにデプロイする場合は、`Additional Behaviours`の`Checkout specific local branch`に`master`をセットする


