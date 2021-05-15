//
//  VideoListCell.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/05/14.
//

import UIKit

class VideoListCell: UICollectionViewCell {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .black
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBOutlet weak var channelImageView: UIImageView!
    
    // xib使うときに呼ばれる。逆に上のやつはxib呼ばれないとき
    override func awakeFromNib() {
        super.awakeFromNib()
        channelImageView.layer.cornerRadius = channelImageView.frame.width / 2
        backgroundColor = UIColor.cyan
    }
    
    
}
