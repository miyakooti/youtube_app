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
    func apiRequest<T: Decodable>(path: PathType, params: [String: Any], type: T.Type, completion: @escaping (T) -> Void) {
            let path = path.rawValue
            let url = baseURL + path + "?"
            
            var params = params
            params["key"] = Sensitive.apiKey
            params["part"] = "snippet"
            
            let request = AF.request(url, method: .get, parameters: params)
            
            request.responseJSON { (response) in
                do {
                    guard let data = response.data else { return }
                    let decode = JSONDecoder()
                    let value = try decode.decode(T.self, from: data)
                    
                    completion(value)
                } catch {
                    print(T.self)
                    print("変換に失敗しました。: ", error)
                }
            }
        }
}
