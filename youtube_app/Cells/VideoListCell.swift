//
//  VideoListCell.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/05/14.
//

import UIKit

class VideoListCell: UICollectionViewCell {
    
    static let identifier = "VideoListCellId"
    static func nib() -> UINib {
        return UINib(nibName: "VideoListCell", bundle: nil)
    }
    
    
    
    var videoItem: Item? {
        didSet{
            guard let url = URL(string: videoItem?.snippet.thumbnails.medium.url ?? "") else { return }
                do {
                    let data = try Data(contentsOf: url)
                    thumbnailImageView.image = UIImage(data: data)
                } catch {
                    print("データからUIImageに変換できませんでした", error)
                }

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
