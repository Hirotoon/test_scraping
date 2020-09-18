## アプリケーションの用途
- 別のボランティア/求人募集サイトから募集情報を取得し、それをコンテンツにしたり、営業に活用したりする
- スクレイピングは50サイトほどで実施しようと思っているのが、今回は2つのサイトでスクレイピングを実施した
  - 01 : [e-moshicom](https://moshicom.com/search/?keywords=&date_start=&date_end=&disciplines%5B8%5D=11&scale=0&sort=2&disp_limit=20&mode=1)
  - 02 : [Blueship](https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc)
  
## 設計書
 ### データベース設計
   - ER図 ： [リンク](https://drive.google.com/file/d/1BG6DqCpJIUvMroCx0It8MF-LiTIZsPFj/view?usp=sharing)
   - テーブル定義書 : [リンク](https://docs.google.com/spreadsheets/d/1Zu_bcyZ3IGHnPhZ58Kem7ju5JCkS57IWpy5RNjjH6C4/edit?usp=sharing)
 ### アプリケーション詳細設計
   - 設計書 :[リンク](https://docs.google.com/spreadsheets/d/1guqn0xewpb70CG3I0qvRNz7gktmjY6LdOlA2HyqDxas/edit?usp=sharing)

## モデル
 ### Admin(管理者)
  - パスワード
  - メールアドレス
 
 ### Group(登録している団体)
  - 団体名
  - 活動エリア
  - 住所
  - メールアドレス
  - 電話番号
  - 団体説明
  - プロフィール画像

### Volunteer(ボランティア求人情報)
 - タイトル名
 - 主催者名
 - 開催日
 - 開催時間
 - 開催場所
 - ボランティア説明
 - イメージ画像
 - 詳細URL
 - 団体ID(アソシエーションのため)

## タスク 
 ### Scrapeタスク
  - volunteers_scraping/lib/tasks/scrape.rb
    - 定時に上記のe-moshicomサイトをスクレイピング
    - 定時に上記のBlueshipサイトをスクレイピング
    - 未保存の募集情報が存在すれば、Volunteersテーブルに保存
 
 ### Connectタスク
  - volunteers_scraping/lib/tasks/connect.rb
    - 登録されている団体とボランティア情報を紐付ける
    - 団体の団体名とボランティア情報の主催者名が一致した場合

## Rspec

 ### タスクが正常に動作するか
  - Connectタスクが正常に動作する
  - Scrapeタスクが正常に動作する
  
 ### モデル
  - Groupモデルのテスト
    - バリデーションのテスト
    - アソシエーションのテスト
   
  - Volunteerモデルのテスト
    - バリデーションのテスト
    - アソシエーションのテスト
 
 ### 「スクレイピングによって得た求人募集情報」一覧ページ
  - 登録されている団体と紐づいたボランティアが表示される
  - 登録されている団体と紐づいていないボランティアは表示されない
