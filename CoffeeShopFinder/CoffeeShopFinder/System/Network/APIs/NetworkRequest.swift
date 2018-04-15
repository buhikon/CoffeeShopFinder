//
//  NetworkRequest.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case get, post, put, delete
    
    var stringValue: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        }
    }
}
enum HTTPQueryPosition { case URL, messageBody }

class NetworkRequest: NSObject {
    
    var serverAddress = "https://api.foursquare.com/v2"
    var path: String = ""
    var method = HTTPMethod.get
    var jsonData: [String : Any] = ["client_id":NetworkConstant.client_id,
                                    "client_secret":NetworkConstant.client_secret,
                                    "v":"20180415"
    ]
    var httpHeader: [String: String]? = nil
    var queryPosition: HTTPQueryPosition {
        get {
            if method == .post || method == .put {
                return .messageBody
            }
            else {
                return .URL
            }
        }
    }
    var urlRequest: URLRequest? {
        get {
            func getUrl() -> URL? {
                guard let url = URL(string: serverAddress) else {
                    return nil
                }
                
                switch queryPosition {
                case .messageBody:
                    return url
                case .URL:
                    // default server address may contain path components.
                    // e.g.
                    // serverAddress : http://aaa.com/api
                    // path : /v1/getUserInfo
                    // ----> path : /api/v1/getUserInfo
                    let path = "\(url.path)\(self.path)"
                    
                    if var components = URLComponents(string: serverAddress) {
                        components.path = path
                        
                        if jsonData.keys.count > 0 {
                            //                            var query = ""
                            //                            let params = Array(jsonData.keys)
                            //                            for i in 0..<params.count {
                            //                                let key = params[i]
                            //                                let value = jsonData[key]!
                            //
                            //                                if i > 0 {
                            //                                    query += "&"
                            //                                }
                            //                                query += "\(key)=\(value)"
                            //                            }
                            //                            components.query = query
                            
                            let params = Array(jsonData.keys)
                            for i in 0..<params.count {
                                let key = params[i]
                                let value = String(describing: jsonData[key]!)
                                
                                if components.queryItems == nil {
                                    components.queryItems = []
                                }
                                components.queryItems!.append(URLQueryItem(name: key, value: value))
                            }
                        }
                        return components.url
                    }
                    else {
                        return nil
                    }
                }
            }
            
            if let url = getUrl() {
                var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: NetworkConstant.timeout)
                request.httpMethod = method.stringValue
                
                // set http header
                if let httpHeader = httpHeader {
                    let headerFields = Array(httpHeader.keys)
                    for headerField in headerFields {
                        let value = httpHeader[headerField]
                        request.setValue(value, forHTTPHeaderField: headerField)
                    }
                    
                }
                
                // set message body and content length
                switch queryPosition {
                case .messageBody:
                    var postLength = "0"
                    do {
                        let postData = try JSONSerialization.data(withJSONObject: jsonData, options: .sortedKeys)
                        request.httpBody = postData
                        postLength = "\(postData.count)"
                    }
                    catch {
                        
                    }
                    request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                    break
                case .URL:
                    break
                }
                
                return request
            }
            else {
                return nil
            }
        }
    }
}

