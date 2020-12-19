//
//  URLSessionMock.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 16/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
