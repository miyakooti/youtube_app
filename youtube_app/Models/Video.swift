import Foundation

class Video: Decodable { //jsonデータをデコードできる、という意味。
    let kind: String
    let items: [Item] //リスト[ ]のやつ
}

class Item: Decodable { // 逆にxcodeとかで書いたデータをjsonにしたいときは、codable（ユーザーアプリでやったやつ！）
    let snippet: Snippet
    
    // channelのアイコンの情報をあとづけする
    var channel: Channel?
}

class Snippet: Decodable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnail
    
}

class Thumbnail: Decodable { // channelと共有しているので注意。
    
    let medium: ThumbnailInfo
    let high: ThumbnailInfo
    
}

class ThumbnailInfo: Decodable { // mediumとhigh
    let url: String
    let width: Int?
    let height: Int?
}
