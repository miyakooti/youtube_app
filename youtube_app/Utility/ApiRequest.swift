//
//  ApiRequest.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/06/03.
//

import Foundation
import Alamofire

class ApiRequest {
    
    enum PathType: String {
        case search
        case channels
    }
    
    static var shared = ApiRequest() // apiRequestに対してstatiｃ書くだけでなく、こういう書き方もある。
    
    private let baseURL = "https://www.googleapis.com/youtube/v3/"

    
    
    // completionはコールバック。
    // じぇねりくす
    func apiRequest<T: Decodable>(path: PathType, params: [String: Any], type: T.Type ,completion: @escaping (T) -> Void) {
       
        // urlつくる
        let path = path.rawValue
        let url = baseURL + path + "?" // ?はパラメータ始まる合図？
        var params = params
        
        params["key"] = Sensitive.apiKey
        params["part"] = "snippet"
    
        print(url)
        print(params)
        
        let request = AF.request(url, method: .get, parameters: params) // alamofire神やんけ　勝手にパラメータをurlに組み込んでくれる
        
        request.responseJSON { (response) in
            debugPrint(request)
            
            do {
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)

                completion(value)
                
            } catch {
                print("searchでデコードに失敗", error)
            }
        }
 
    }
}
