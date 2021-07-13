//
//  ListAPI.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import Alamofire
import ObjectMapper

class ListAPI: Network {

    func getList(param: Dictionary<String,Any>, completion: @escaping (Bool, ListModel?, APIType) -> Void) {
        AF.request(baseURL, method: .get, parameters:param, headers: headers).responseJSON { response in
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
