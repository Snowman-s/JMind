# JMind
MindをJVM上で動くように!  

# 初期化
- Mind(最低バージョン8)をインストールする。  
- https://github.com/Snowman-s/MindTools をクローンし、手順に従ってセットアップする。
- 「compileutf8.cmd」を、このREADMEファイルのディレクトリで実行する。
# 実行
- 「jmind/」内に、UTF8で好きなファイル名でMindプログラムを書く。
- sjmindc jmind/<file_name>でそのソースをコンパイルする。
- 「cd jmind」を実行し、「java <file_name(no ext)>」でコンパイルした.classファイルが動作します。
# 現在の注意点(後々修正)
- 関数宣言は一つまで
- 変数宣言はできない
- 現在「表示する」、「一行表示する」しか使用不可
- 文字列しかスタックに詰めず、数値は積めない
- イニシャライザ(コンストラクタ)未定義
- 文字列内に空白や読点などの区切り文字を含めることができない
# 細かい仕様
- .classにはpublicな一つのクラスのみが含まれます。
- 関数は全て「public static」が付けられます。
- 関数の名前は定義がそのまま使用されますが、「メイン」のみ「main」となります。
- 関数の型は普通の関数なら「(java.util.Stack),void」ですが、「メイン」のみ「(java.lang.String[])void」となります。
- 「メイン」では、Stackインスタンスが新しく1つ作成され、それが関数の引数に渡されます。これを使いまわしてプログラムが進行します。例えば「”こんにちは！世界！”」は、「”こんにちは！世界！”をスタックに積む処理」として扱います。
