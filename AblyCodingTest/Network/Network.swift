//
//  NetworkModel.swift
//  AblyCodingTest
//
//  Created by 손정욱 on 2021/07/13.
//

import Alamofire

enum APIType {
    case getList             // 리스트 API
}

class Network {
    #if DEBUG
        internal let baseURL  = "http://d2bab9i9pr8lds.cloudfront.net/api/home" // test
    #else
        internal let baseURL  = "http://d2bab9i9pr8lds.cloudfront.net/api/home" // real2
    #endif
    
    let headers : HTTPHeaders = [
        "Accept": "*/*",
        "Content-Type": "application/json"
    ]
}
