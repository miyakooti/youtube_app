//
//  Channel.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/05/31.
//

import Foundation

class Channel: Decodable {
    let items: [ChannelItem]
}

class ChannelItem: Decodable {
    let snippet: ChannelSnippet
}

class ChannelSnippet: Decodable {
    let thumbnails: Thumbnail
}
