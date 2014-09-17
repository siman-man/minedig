### RedmineのチケットAPIから取得できる属性

* project
  * id      プロジェクトのID
  * name    プロジェクトの名前


* tracker
  * id      トラッカーのID
  * name    トラッカーの名前

トラッカーはチケットの大分類です。また、チケットのステータスを、どのロールのユーザーがどのように遷移させることができるのかというワークフローの定義も行います。チケットは必ず一つのトラッカーに所属します。トラッカー無しのチケットは作成できません。


* status
  * id      ステータスのID
  * name    ステータスの名前


* priority
  * id      優先度のID
  * name    優先度の名前


* author
  * id      チケット作成者のID
  * name    チケット作成者の名前


* assigned_to
  * id      担当者のID
  * name    担当者の名前


* fixed_version
  * id      対象バージョンのID
  * name    対象バージョンの名前

対象バージョンとはチケットを構成する項目の一つで、そのチケットがどの「バージョン」に関連づけられているのかを表します。


* subject 題名

* description 説明

* start_date  開始日

* due_date   期日

* done_ratio  進捗率

* estimated_hours  予定工数

* spent_hours  作業時間

* custom_fields
カスタムしたフィールドの一覧が入る。

* created_on  チケットの作成日
* updated_on  チケットの更新日
