//
//  ViewController.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/05/14.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {

    @IBOutlet private weak var videoListCollectionView: UICollectionView!
        
    private var videoItems = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoListCollectionView.backgroundColor = .lightGray
        
        videoListCollectionView.delegate = self
        videoListCollectionView.dataSource = self
        
        videoListCollectionView.register(VideoListCell.nib(), forCellWithReuseIdentifier: VideoListCell.identifier)
        
        fetchYoutubeSearchInfo()
    }
    
    private func fetchYoutubeSearchInfo() {
        let params = ["q": "imperialhal"]
        
        // typeはジェネリクスのやつ。decodableに準拠していればなんでもOKということ。
        
        API.shared.apiRequest(path: .search, params: params, type: Video.self) { (video) in
            print(video)
            self.videoItems = video.items
            let id = self.videoItems[0].snippet.channelId
            self.fetchYoutubeChannelInfo(id: id)
            
        }
    }

    private func fetchYoutubeChannelInfo(id: String) {
            let params = [
                "id": id
            ]
            
            API.shared.apiRequest(path: .channels, params: params, type: Channel.self) { (channel) in
                self.videoItems.forEach { (item) in
                    item.channel = channel
                }
                
                self.videoListCollectionView.reloadData()
            }
        }


}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoItems.count
    }
    
    //セルの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: VideoListCell.identifier, for: indexPath) as! VideoListCell
        cell.videoItem = videoItems[indexPath.row]
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout { // セルのレイアウト決めれる
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return .init(width: width, height: 373) //正方形やんけ
    }
    
}
