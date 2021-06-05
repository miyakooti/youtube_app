//
//  ApiRequest.swift
//  youtube_app
//
//  Created by Arai Kousuke on 2021/06/03.
//

import Foundation
import Alamofire

final class API {
    
    enum PathType: String {
        case search
        case channels
    }
    
    static let shared = API() // apiRequestに対してstatiｃ書くだけでなく、こういう書き方もある。
    
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
                guard let statusCode = response.response?.statusCode else { return }
                guard statusCode <= 300 else { return }
                do {
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    let value = try decoder.decode(T.self, from: data)
                    
                    completion(value)
                } catch {
                    print(T.self)
                    print("変換に失敗しました。: ", error)
                }
            }
        }
}
