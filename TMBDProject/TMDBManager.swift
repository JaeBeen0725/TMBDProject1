//
//  TMDBManager.swift
//  TMBDProject
//
//  Created by Jae Oh on 11/5/23.
//

import UIKit
import SwiftyJSON
import Alamofire

class TMDBManager {
    
    static let shared = TMDBManager()
    
    func callRequestCodable(success: @escaping (TMDBData) -> Void, failure: @escaping () -> Void ) {
        let url = "https://api.themoviedb.org/3/trending/all/week?api_key=\(APIkey.tmdbKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: TMDBData.self){ response in
            
            switch response.result {
            case .success(let value): success(value)
                
            case .failure(let error):
                print(error)
                failure()
            }
            
            
            
        }
    }
    
}
