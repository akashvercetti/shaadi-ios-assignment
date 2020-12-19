//
//  NetworkManager.swift
//  GenericAPI
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error {
    case apiError(message: String)
}

enum requestTypes : String {
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class NetworkManager {
    
    //    static let shared = NetworkManager()
    //    private init() {}
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func makeNetworkCalls<T: Decodable>(urlRequest:URLRequest, objectType: T.Type, completion: @escaping (_ response : T?, _ error:Error?) -> ()) {
        
        
        guard let url = urlRequest.url, url.absoluteString.isValidURL else {
            completion(nil, APIError.apiError(message: "Malformed URL"))
            return
        }
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }
                
                let values = try? JSONDecoder().decode(objectType.self, from: data)
                completion(values, nil)
            }
            
        }.resume()
        
    }
    
    func getBaseRequest(urlStr: String, methodType: requestTypes, params: [String : Any]? = [:], headers: [String: String]? = nil) -> URLRequest {
        
        var request = URLRequest(url: URL(string: urlStr.getURlEncodedString()!)!)
        
        request.httpMethod = methodType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if methodType == .POST, let params = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        return request
    }
}

extension String {
    
    func getURlEncodedString() -> String? {
        let percentencodedurlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return percentencodedurlString
        
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
