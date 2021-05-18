//
//  Request.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/05/18.
//

import Foundation

protocol Request {
    var api: Api { get }
    var url: URL { get }
}
