//
//  ListAPI.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import Alamofire
import ObjectMapper

class ListAPI: Network {

    func getList(completion: @escaping (Bool, ListModel?, APIType) -> Void) {
        AF.request(baseURL, method: .get, parameters:nil, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                print("getList : ",String(decoding: response.data!, as: UTF8.self))
                let listModel = Mapper<ListModel>().map(JSONString: String(decoding: response.data!, as: UTF8.self))
                completion(true,listModel!,.getList)
            case .failure:
                completion(false,nil,.getList)
            }
        }
    }
    
    func getNextList(param: Dictionary<String,Any>, completion: @escaping (Bool, ListModel?, APIType) -> Void) {
        print("param : ",param)
        let url = baseURL+"/goods"
        AF.request(url, method: .get, parameters:param, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                print("getList : ",String(decoding: response.data!, as: UTF8.self))
                let listModel = Mapper<ListModel>().map(JSONString: String(decoding: response.data!, as: UTF8.self))
                completion(true,listModel!,.getList)
            case .failure:
                completion(false,nil,.getList)
            }
        }
    }
}
