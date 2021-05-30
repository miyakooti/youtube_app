//
//  ViewController.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/05/14.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var videoListCollectionView: UICollectionView!
        
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
        // ここからが本番
        let urlString = "https://www.googleapis.com/youtube/v3/search?q=apexlegends&key=\(Sensitive.apiKey)&part=snippet"
        
        let request = AF.request(urlString)
        request.responseJSON { (response) in
            
            do {
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                let video = try decoder.decode(Video.self, from: data) //モデルに格納できるんだ、、、すげー、、、
                print("video:", video.items.count)
                self.videoItems = video.items
                
                // search→channerで、チャンネルの情報を取得
    
                
                self.videoListCollectionView.reloadData()
            } catch {
                print("jsonのデコードに失敗しました：", error)
            }
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
