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
    
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        videoListCollectionView.backgroundColor = .red
        videoListCollectionView.delegate = self
        videoListCollectionView.dataSource = self
        
        videoListCollectionView.register(VideoListCell.self, forCellWithReuseIdentifier: cellId)
        videoListCollectionView.register(UINib(nibName: "VideoListCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        // ここからが本番
        let urlString = "https://www.googleapis.com/youtube/v3/search?q=apexlegends&key=AIzaSyBeKZ7M-SRhSNN2jFIiJhIHwHdWllTfTnk&part=snippet"
        
        let request = AF.request(urlString)
        request.responseJSON { (response) in
//            print("responce", response)
            
            
            do {
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                let video = try decoder.decode(Video.self, from: data) //モデルに格納できるんだ、、、すげー、、、
                print("video:", video.items.count)
            } catch {
                print("jsonのデコードに失敗しました：", error)
            }
        }
        
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout { // セルのレイアウト決めれる
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return .init(width: width, height: 373) //正方形やんけ
    }
    
}
