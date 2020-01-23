# JMind
MindをJVM上で動くように!  
# 初期化
- Mind(最低バージョン8)をインストールする。  
- https://github.com/Snowman-s/MindTools をクローンし、手順に従ってセットアップする。
- Mindのインストールディレクトリ内の「srclib」内にある、「uniencode.src」および「unidecode.src」を、このREADME.mdと同じパスにコピペする。
- 「compileutf8.cmd」を、このREADMEファイルのディレクトリで実行する。
# 実行
- 「jmind/」内に、UTF8で好きなファイル名でMindプログラムを書く。(他の場所でもいいですが、jmind内に書けばgitに無視されるので、推奨します。)
- .\sjmindc jmind\\\<file_name>でそのソースをコンパイルする。
  - **パスの区切りとして「/」は使用できません。**
- 「cd jmind」を実行し、「java <file_name(no ext)>」でコンパイルした.classファイルが動作します。
# 現在の注意点(後々修正)
- 機能は大幅に制限されている
- 関数宣言は一つまで
- 変数宣言はできない
- イニシャライザ(コンストラクタ)未定義
- JVMスタック使用数は255個を書き込みますが――
# これを開発するときの注意点
- 新しいソースファイルを追加する場合、「compileutf8.cmd」及び「.gitignore」の記述をお願いします。「jmindc.src」での「～を　コンパイル。」の記述も忘れないでください。
- debug.src内の「テストモード」の値は以下のように作用します。
  1. テストモードが１ならば、「～をログする」「～をテスト表示」系の単語が動作します。０ならばそれらはほぼ無処理扱いになります(スタックの整合性は取られます)。
  1. テストモードが１ならば、dataフォルダ(実行時に内部で使用されるファイル置き場)内のファイルは残ったままになります。０ならばそれらはすべて削除されます。
- 変数宣言のためには、ローカル変数個数や現在使用中のローカル変数個数、およびそのローカル変数のデータを書き込めば良いと思われます。forが変数の枠をとっているため、参考にしてください。
# 細かい仕様
- .classにはpublicな一つのクラスのみが含まれます。
- 関数は全て「public static」が付けられます。
- 関数の名前は定義がそのまま使用されますが、「メイン」のみ「main」となります。
- 関数の型は普通の関数なら「(java.util.LinkedList)void」ですが、「メイン」のみ「(java.lang.String[])void」となります。
- 「メイン」では、LinkedListインスタンスが新しく1つ作成され、それが関数の引数に渡されます。これを使いまわしてプログラムが進行します。例えば「”こんにちは！世界！”」は、「”こんにちは！世界！”を引数にLinkedListインスタンスのaddFirstを呼ぶ処理」として扱います。
- package宣言はありません。
- dataフォルダ内には、このプログラム実行時に様々なファイルが書き込まれるので、使用しないようにしてください。
# 使用可能単語
## 基本的なデータ
- 文字列 - '「'と'」'で囲まれた単語は文字列として扱われます。空白や読点などの区切り文字も使用できます。
- 文字 - 「'」で囲まれた単語は文字(等価な整数)として扱われます。Characterとして**ではなく、**Integerとして扱われます。
- 数値 - ４バイトを超えると誤動作します。
- 真偽値 - 数値と同じです。(Javaとは違いtrueは1,falseは0の整数として書いてください。内部でもそのように扱われます。)
## 表示
1. 『何でも～』系単語に文字を渡すと、数値として扱われてしまいます。
- 何でも表示 - スタックから１つ取り出し、何でもいいから標準出力します。（文字列でなくても表示されます。）
- 何でも一行表示 - スタックから１つ取り出し、何でもいいから標準出力し、改行します（文字列でなくても表示されます。）
- 表示 - スタックから１つ取り出し、その文字列を標準出力します。（文字列でなければエラーが出ます。）
- 一行表示 - スタックから１つ取り出し、その文字列を標準出力し、改行します（文字列でなければエラーが出ます。）
- エラー扱いで表示 - スタックから１つ取り出し、その文字列をエラーストリームへ出力します。（文字列でなければエラーが出ます。）
- エラー扱いで一行表示 - スタックから１つ取り出し、その文字列をエラーストリームへ出力し、改行します（文字列でなければエラーが出ます。）
- エラー扱いで何でも表示 - スタックから１つ取り出し、何でもいいからエラーストリームへ出力します。（文字列でなくても表示されます。）
- エラー扱いで何でも一行表示 - スタックから１つ取り出し、何でもいいからエラーストリームへ出力し、改行します（文字列でなくても表示されます。）
- 改行 - 標準出力で改行します。
## 標準入力
- 一つ文字列入力 - 標準入力から文字列を受け付け、スタックに積みます。（空白などで区切られている場合、最初の部分だけ読みます。）
- 文字列入力 - 標準入力から文字列を受け付け、スタックに積みます。（空白などで区切られているかに関わらず、必ず一行読み出します。）
- 一つ数値入力 - 標準入力から整数を受け付け、スタックに積みます。
  1. 整数は１０進数で受け取ります。
  1. 空白などで区切られている場合、最初の部分だけ読みます。
  1. 入力が数値でない場合、java.util.InputMismatchException例外が投げられます。
## 整数計算
- 加える - スタックにある２つの整数を加えスタックに積みます。
- 引く - スタックに２つ積まれている整数を使用して減算しスタックに積みます。**逆転介入はまだありません。例えば「６から　２を　引く」の様な順番で使用してください。**
- 掛ける - スタックにある２つの数を掛けスタックに積みます。
- 割る - スタックに２つ積まれている整数を使用して除算しスタックに積みます。**逆転介入はまだありません。例えば「６を　２で　割る」の様な順番で使用してください。**
- 割った余り - スタックに２つ積まれている整数を使用して剰余計算しスタックに積みます。**逆転介入はされません。例えば「６を　２で　割った余り」の様な順番で使用してください。**
- ＡＮＤ - スタックにある整数２つを使用して「ＡＮＤ」ビット演算しスタックに積みます。
- ＯＲ - スタックにある整数２つを使用して「ＯＲ」ビット演算しスタックに積みます。
- ＸＯＲ - スタックにある整数２つを使用して「ＸＯＲ」ビット演算しスタックに積みます。
- 左シフト - スタックにある整数２つを使用して左シフトしスタックに積みます。**逆転介入はまだありません。例えば「６を　２ビットだけ　左シフト」の様な順番で使用してください。**
- 右シフト - スタックにある整数２つを使用して右シフトしスタックに積みます。**逆転介入はまだありません。例えば「６を　２ビットだけ　右シフト」の様な順番で使用してください。** 符号ビットを特別扱いしません。
- 負数 - スタックにある整数を１つ使用してそれの符号を反転し、スタックに積みます。（例：－５の　負数　⇒　５）
- ＮＯＴ - スタックにある整数を１つ使用して、「ＮＯＴ」ビット演算し、スタックに積みます。
- 一つ加え - スタックにある整数を１つ使用して、１を足して、スタックに積みます。
- 二つ加え - スタックにある整数を１つ使用して、２を足して、スタックに積みます。
- 一つ引き - スタックにある整数を１つ使用して、１を引き、スタックに積みます。
- 二つ引き - スタックにある整数を１つ使用して、２を引き、スタックに積みます。
## 二値整数検査
- 等しい - スタックにある数２つを使用して等しいか比較しその真偽値をスタックに積みます。
- 異なる - スタックにある数２つを使用して異なるか比較しその真偽値をスタックに積みます。
- 大きい - スタックにある数２つを使用して大きいか比較しその真偽値をスタックに積みます。**逆転介入はまだありません。例えば「６が　２より　大きい」の様な順番で使用してください。**
- 小さい - スタックにある数２つを使用して小さいか比較しその真偽値をスタックに積みます。**逆転介入はまだありません。例えば「６が　２より　小さい」の様な順番で使用してください。**
- 以上 - スタックにある数２つを使用して大きいまたは等しいか比較しその真偽値をスタックに積みます。**逆転介入はまだありません。例えば「６が　２　以上」の様な順番で使用してください。**
- 以下 - スタックにある数２つを使用して小さいまたは等しいか比較しその真偽値をスタックに積みます。**逆転介入はまだありません。例えば「６が　２　以下」の様な順番で使用してください。**
## 一値整数検査
- ゼロ？ - スタックにある数１つを取り出し、０に等しいかどうかの真偽値をスタックに積みます。
- ゼロ以外？ - スタックにある数１つを取り出し、０と異なるかどうかの真偽値をスタックに積みます。
- 正？ - スタックにある数１つを使用して０**以上**かどうかの真偽値をスタックに積みます。
- 負？ - スタックにある数１つを使用して０より小さいかどうかの真偽値をスタックに積みます。
- 正の数？ - スタックにある数１つを使用して０**より大きい**かどうかの真偽値をスタックに積みます。
## スタック操作単語
- 指定番号のスタック要素を得る - スタックから整数を1つ取り出し、スタックの手前からその番号の要素を取り出し、スタックの先頭に置きます。例：[10,20,30,2] -> [10,30,20]
  1. **番号は１から始まります。**
- 捨てる - スタックのもっとも手前のデータを削除します。例：[10,20,30] -> [10,20]
- 複写する - スタックのもっとも手前のデータを複製し、それをスタックに積みます。例：[10,20,30] -> [10,20,30,30]
- スタックサイズ - 現在のスタックのサイズを得て、スタックに積みます。例：[10,20,30] -> [10,20,30,3]
- 二番目を捨てる - スタックの手前から２番目のデータを削除します。例：[10,20,30] -> [10,30]
- スワップ - スタックの最も手前のデータと手前から２番目のデータの場所を入れ替えます。例：[10,20,30] -> [10,30,20]
## 文字列操作単語
- 文字数 - スタックから一つ文字列を取り出し、その文字数を得て、スタックに積みます。
- 文字数 - スタックから一つ文字列を取り出し、その文字数がゼロかどうかの真偽値を得て、スタックに積みます。
- 等しい文字列？ - スタックから二つ文字列を取り出し、その文字数が同じ文字の並びかどうかの真偽値を得て、スタックに積みます。
- 一文字検索 - スタックから文字列と文字を取り出し、その文字が文字列のどこにあるかの数値をインデックスに積みます。**位置は１から始まります。** ただし、見つからなかった場合、０が積まれます。
- 検索 - スタックから文字列１と文字列２を取り出し、その文字列２が文字列１のどこにあるかの数値をインデックスに積みます。**位置は１から始まります。** ただし、見つからなかった場合、０が積まれます。
- 合成 - スタックから文字列１と文字列２を取り出し、文字列１の後ろに文字列２をつなげた文字列をスタックに積みます。
# 使用可能構文
## 分岐
1. 「さもなければ」は省略可能です。
1. 「もし」は無視されますので、日本語上必要な箇所に挿入することが可能です。
1. 分岐内の文が一つの場合であっても、「つぎに」は省略不可です。
- ならば～(さもなければ)～つぎに - スタックから数値を一つ取り出し、それが１（真）に等しい(正確には０と異なる)なら「ならば～さもなければ」内が、そうでなければ「さもなければ～つぎに」内が実行されます。
  - 所謂if-[else]-endif文に相当します。
- でなければ～(さもなければ)～つぎに - スタックから数値を一つ取り出し、それが０（偽）に等しいなら「ならば～さもなければ」内が、そうでなければ「さもなければ～つぎに」内が実行されます。
  - しいて言えばif notやif!に相当します。
## forループ
1. 「回数」をforループ内に記述すると、それが何回目のループかの数値がスタックに積まれます。ただし、**１**から始まることに注意してください。
1. ループ内に「打ち切り」を記述するとその場でループを抜けます。
1. ループ内に「もう一度」を記述するとその場でループをやり直します。
- 回数指定し～繰り返し - スタックから数値を一つ取り出し、その回数だけ内部が繰り返し実行されます。
- 逆向き回数指定し～繰り返し - スタックから数値を一つ取り出し、その回数だけ内部が繰り返し実行されます。**「回数」の順番が逆になります。(n→1)**
## while(true)ループ
1. 「回数」は機能しません。
1. ループ内に「打ち切り」を記述するとその場でループを抜けます。
1. ループ内に「もう一度」を記述するとその場でループをやり直します。
- ここから～繰り返し - 内部がずっと繰り返し実行されます。「打ち切り」等でループを脱出する処理が通常は必要です。
## コメント
1. 「※」の後、その行が終わるまでは全てコメントになります。
1. 「（」「）」で囲まれた部分は、**括弧の両端が他の文字と隣り合っていなければ**コメントになります。
## その他
- 無処理 - 何もしません。
- 終わり - その関数を終了(return void)します。
- 実行終わり - 現在実行中のこのプログラムを終了します。