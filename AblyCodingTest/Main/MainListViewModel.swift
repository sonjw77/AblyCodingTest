//
//  MainListViewModel.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import RxSwift

class MainListViewModel {

    let listAPI = ListAPI()
    let disposeBag = DisposeBag()
    let listSuccess = PublishSubject<Void>()
    var listModel: ListModel?
    var bannerList: [ListModel.Banners]?
    var goodsList: [ListModel.Goods]?
    var lastID = ""
    var isLastPage = false
    /**
     초기 셋팅
     */
    func configure() {
        getFirstList()
    }
    
    /**
     리스트 불러오기 제일 처음에 호출
     */
    func getFirstList() {
        listAPI.getList(param: getParam()) {[weak self] (isSuccess , model , apiType) in
            if isSuccess {
                self?.listModel = model
                self?.bannerList = self?.listModel?.banners
                self?.goodsList = self?.listModel?.goods
                self?.checkLastPage()
                self?.listSuccess.onNext(())
            }
        }
    }
    
    /**
     리스트 불러오기 제일 처음에 호출
     */
    func getNextList() {
        listAPI.getList(param: getParam()) {[weak self] (isSuccess , model , apiType) in
            if isSuccess {
                self?.listModel = model
                self?.goodsList?.append(contentsOf: self?.listModel?.goods ?? [ListModel.Goods]())
                self?.checkLastPage()
                self?.listSuccess.onNext(())
            }
        }
    }
    
    /**
     배너 아이템 반환
     */
    func getBannerItem(index: Int) -> ListModel.Banners {
        return bannerList?[index] ?? ListModel.Banners(JSON: ["id":"-1","image":""])!
    }
    
    /**
     리스트 아이템 반환
     */
    func getListItem(index: Int) -> ListModel.Goods {
        return goodsList?[index] ?? ListModel.Goods(JSON: ["id":"-1","name":"","image":""])!
    }
    
    /**
     마지막 페이지 체크
     */
    func checkLastPage() {
        if listModel?.goods?.count == 0 {
            isLastPage = true
        }
    }
    
    /**
     API 요청할 파라메터 값을 만든다.
     */
    func getParam() -> Dictionary<String,Any> {
        var param: [String: Any] = [:]
        if lastID != "" {
            param["lastId"] = lastID
        }
        return param
    }
}
