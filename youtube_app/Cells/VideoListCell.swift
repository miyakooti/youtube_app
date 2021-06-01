//
//  VideoListCell.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/05/14.
//

import UIKit
import Nuke

class VideoListCell: UICollectionViewCell {
    
    static let identifier = "VideoListCellId"
    static func nib() -> UINib {
        return UINib(nibName: "VideoListCell", bundle: nil)
    }
    
    
    
    var videoItem: Item? {
        didSet{
            guard let url = URL(string: videoItem?.snippet.thumbnails.medium.url ?? "") else { return }
            guard let channelUrl = URL(string: videoItem?.channel?.items[0].snippet.thumbnails.medium.url ?? "") else { return }
            
            // nuke便利すぎて草
            Nuke.loadImage(with: url, into: thumbnailImageView)
            Nuke.loadImage(with: channelUrl, into: channelImageView)
            
            // nuke使わないバージョン
//            do {
//                let data = try Data(contentsOf: url)
//                thumbnailImageView.image = UIImage(data: data)
//                let channelData = try Data(contentsOf: channelUrl)
//                channelImageView.image = UIImage(data: channelData)
//
//            } catch {
//                print("データからUIImageに変換できませんでした", error)
//            }
            
            titleLabel.text = videoItem?.snippet.title
            descriptionLabel.text = videoItem?.snippet.description
        }
    }
    

    
    
    @IBOutlet private weak var channelImageView: UIImageView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // xib使うときに呼ばれる。逆に上のやつはxib呼ばれないとき
    override func awakeFromNib() {
        super.awakeFromNib()
        channelImageView.layer.cornerRadius = channelImageView.frame.width / 2
        backgroundColor = UIColor.clear
    }
    
    
}
