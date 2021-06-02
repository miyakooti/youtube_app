# youtube_app
apiとの連携やalamofireの練習がてらに作成したアプリです。

# 実行方法
Sensitive.swiftというファイルは、APIキーなどの隠す必要がある文字列などを格納する構造体が定義されます。
.gitignoreで無視しているので、ファイル名を右クリックしてSensitive.swiftを作成して、次のように定義をしてください。

<img width="262" alt="スクリーンショット 2021-05-30 23 32 41" src="https://user-images.githubusercontent.com/60727025/120108256-55e58c80-c19f-11eb-872c-5f234e5c80d0.png">

~~~
import Foundation

struct Sensitive {
    static var apiKey: String {
        return "ここにalamofireのapiキーを入力してください。"
    }
}
~~~

次にワークスペースに移動して、ターミナルで次のコマンドを入力してください。

~~~
pod install
~~~
　これでビルドができるはずです。


# 学んだこと
- Collection View Flow LayoutのEstimate SizeはNoneにできる
- awakefornibはxib使うときにしか呼ばれない
- xibはviewからつくれる
- stackview、内部の要素の大きさに対して動的に変わってくれるのでマジ便利
- jsonで受け取ったデータは、JSONEncoderで簡単にモデルに準拠させることができる
- AFは天才
- try do catchを初めて実践で使えた
- 任意のブレイクポイントで止めると、変数などの状態を右下のボタンで見ることができる
- debugPrintちょっとだけ便利
- 

# 学んだこと(git)
- swiftだけじゃなくて、gitignoreについてかなり調べた。storyboardちょっと動かすだけでも差分出るのでgitignoreは必須だ。。
- キャッシュ残ってるとインデックスに追加されたままになるので、一度キャッシュをすべて削除するのが良い。
- xcodeのgitignoreのテンプレができたので良かった。Sensitiveファイルも無視できてる。
- 今回のプロジェクトでは、PodやSensitive.swiftなどは、クローンした後自分でインストールしたり、新規作成したりする必要がある。これをreadmeにかけってことか！！！楽しい！！！
- jsonをデコードしてインスタンス化するとき、多分他のモデルのやつ再利用してもOK。正直見づらくなりそうなので、排他的に定義したい部分ではある。
- try do catchにおいて、tryが②個あってもOK
- forEach初めて実践で使った
- ジェネリクス
- [nuke - powerful loading image](https://github.com/kean/Nuke)
- 軽くだけどコールバック



# これから学びたいこと
- 自分で仕様書を読んで、このデータは何を表しているのか、このパラメーターはどんな意味があるのか、などを自分で読み解きたい
- gitやqiitaのapiもあるようなので叩いてみたい
- とにかくapiを利用したアプリを作ってみたい。google検索apiとかあったら、電車の時間を返すアプリとか面白そう。
- nukeで最適化
- nuke使わずに最適化

# 参考文献
- [gitのキャッシュ削除](https://qiita.com/fuwamaki/items/3ed021163e50beab7154)
- [めちゃ面白分かりやすかったジェネリクス](https://kentaro.app/posts/swift-generics)



