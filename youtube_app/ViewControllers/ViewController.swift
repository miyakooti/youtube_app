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
//        // ここからが本番
//        let urlString = "https://www.googleapis.com/youtube/v3/search?q=apexlegends&key=\(Sensitive.apiKey)&part=snippet"
////        print(urlString)
//
//        let request = AF.request(urlString)
//        request.responseJSON { [self] (response) in
//
//            do {
//                guard let data = response.data else { return }
//                let decoder = JSONDecoder()
//                let video = try decoder.decode(Video.self, from: data) //モデルに格納できるんだ、、、すげー、、、
//                print("video:", video.items.count)
//                self.videoItems = video.items
//
//                // search→channerで、チャンネルの情報を取得
//
//                let id = self.videoItems[0].snippet.channelId
//                fetchYoutubeChannelInfo(id: id)
//
//                self.videoListCollectionView.reloadData()
//            } catch {
//                print("searchでデコードに失敗", error)
//            }
//        }
    }

    private func fetchYoutubeChannelInfo(id: String) {
        let path = "search"
        let params = ["q": "imperialHal"]
        apiRequest(path: path, params: params) {
            
        }
//        // ここからが本番
//        let urlString = "https://www.googleapis.com/youtube/v3/channels?key=\(Sensitive.apiKey)&part=snippet&id=\(id)"
//        print(urlString)
//
//        let request = AF.request(urlString)
//        request.responseJSON { (response) in
//
//            do {
//                guard let data = response.data else { return }
//                let decoder = JSONDecoder()
//                let channel = try decoder.decode(Channel.self, from: data)
//
//                self.videoItems.forEach { (item) in
//                    item.channel = channel
//                }
//                // search→channerで、チャンネルの情報を取得
//                self.videoListCollectionView.reloadData()
//            } catch {
//                print("channelでデコードに失敗", error)
//            }
//        }
    }
    
    // completionはコールバック。
    private func apiRequest(path: String, params: [String: Any], completion: @escaping () -> Void) {
        let baseURL = "https://www.googleapis.com/youtube/v3/"
        let path = path
        let url = baseURL + path + "?" // ?はパラメータ始まる合図？
        
        var params = params
        
        params["key"] = Sensitive.apiKey
        params["part"] = "snippet"
        
//        let params = [
//            "key": Sensitive.apiKey,
//            "part": "snippet"
//            "id": ""
//        ]
        
//        let request = AF.request(urlString)
        let request = AF.request(url, method: HTTPMethod.get, parameters: params) // alamofire神やんけ
        
        request.responseJSON { (response) in
            
            do {
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                let channel = try decoder.decode(Channel.self, from: data) //モデルに格納できるんだ、、、すげー、、、

                
                completion()
                
                // search→channerで、チャンネルの情報を取得
                
//                let id = self.videoItems[0].snippet.channelId
//                fetchYoutubeChannelInfo(id: id)
//
//                self.videoListCollectionView.reloadData()
            } catch {
                print("searchでデコードに失敗", error)
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
