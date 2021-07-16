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
    let firstListSuccess = PublishSubject<Void>()
    let nextListSuccess = PublishSubject<Void>()
    var listModel: ListModel?
    var bannerList: [ListModel.Banners]?
    var goodsList: [ListModel.Goods]?
    var lastID = -1
    var isLastPage = false
    
    /**
     초기 셋팅
     */
    func configure() {
        getFirstList()
    }
    
    //MARK: - GET 함수
    
    /**
     리스트 불러오기 제일 처음에 호출
     */
    func getFirstList() {
        listAPI.getList() {[weak self] (isSuccess , model , apiType) in
            if isSuccess {
                self?.listModel = model
                self?.bannerList = self?.listModel?.banners
                self?.goodsList = self?.listModel?.goods
                self?.checkLastPage()
                self?.firstListSuccess.onNext(())
            }
        }
    }
    
    /**
     다음 리스트 불러오기
     */
    func getNextList() {
        listAPI.getNextList(param: getParam()) {[weak self] (isSuccess , model , apiType) in
            if isSuccess {
                self?.listModel = model
                self?.goodsList?.append(contentsOf: self?.listModel?.goods ?? [ListModel.Goods]())
                self?.checkLastPage()
                self?.nextListSuccess.onNext(())
            }
        }
    }
    
    /**
     배너 아이템 반환
     */
    func getBannerItem(index: Int) -> ListModel.Banners {
        bannerList?[index] ?? ListModel.Banners(JSON: ["id":"-1","image":""])!
    }
    
    /**
     배너 아이템 갯수 반환
     */
    func getBannerItemCount() -> Int {
        bannerList?.count ?? 0
    }
    
    /**
     리스트 아이템 반환
     */
    func getListItem(index: Int) -> ListModel.Goods {
        goodsList?[index] ?? ListModel.Goods(JSON: ["id":"-1","name":"","image":""])!
    }
    
    /**
     리스트 아이템 갯수 반환
     */
    func getListItemCount() -> Int {
        goodsList?.count ?? 0
    }
    
    /**
     API 요청할 파라메터 값을 만든다.
     */
    func getParam() -> Dictionary<String,Any> {
        var param: [String: Any] = [:]
        if lastID != -1 {
            param["lastId"] = lastID
        }
        return param
    }
    
    // MARK: - ETC
    /**
     마지막 페이지 체크
     */
    func checkLastPage() {
        if listModel?.goods?.count == 0 {
            isLastPage = true
        } else {
            lastID = listModel?.goods?.last?.id ?? -1
        }
    }
    
    /**
     pull to refresh 일때 데이터 초기화
     */
    func resetData() {
        bannerList?.removeAll()
        goodsList?.removeAll()
        isLastPage = false
        lastID = -1
    }
}
