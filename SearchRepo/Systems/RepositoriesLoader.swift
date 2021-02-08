//
//  RepositoriesLoader.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

import Foundation


class RepositoryLoader{
    var search: SearchModel?
    var canLoadNext = true
    var isLoading: Bool{
        get{
            isFirstThreadLoading || isSecondThreadLoading
        }
    }
    private var isFirstThreadLoading = false
    private var isSecondThreadLoading = false
    
    private var entries: [RepositoryModel] = []
    private var firstThreadResult: [RepositoryModel] = []
    private var secondThreadResult: [RepositoryModel] = []
    
    func getEntries() -> [RepositoryModel]{
        return entries + firstThreadResult + secondThreadResult
    }
    
    func clean(){
        entries = []
        firstThreadResult = []
        secondThreadResult = []
    }
    
    func loadNextPage(completionHandler: @escaping () -> Void){
       if self.search == nil || isLoading{
            return
        }
        search!.page += 1
        var thread1Search = search!
        thread1Search.per_page = Int(search!.per_page / 2)
        thread1Search.page = 2 * search!.page - 1
        var thread2Search = search!
        thread2Search.per_page = thread1Search.per_page
        thread2Search.page = 2 * search!.page
        entries += firstThreadResult + secondThreadResult
        firstThreadResult = []
        secondThreadResult = []
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.isFirstThreadLoading = true
            API.shared.search(thread1Search, successHandler: {searchResponse in
                self.firstThreadResult = searchResponse.items
                self.canLoadNext = searchResponse.totalCount != self.getEntries().count
                completionHandler()
                self.isFirstThreadLoading = false
            }, failureHandler: {requestError in
                completionHandler()
                self.isFirstThreadLoading = false
            })
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.isSecondThreadLoading = true
            API.shared.search(thread2Search, successHandler: {searchResponse in
                self.secondThreadResult = searchResponse.items
                self.canLoadNext = searchResponse.totalCount != self.getEntries().count
                completionHandler()
                self.isSecondThreadLoading = false
            }, failureHandler: {requestError in
                completionHandler()
                self.isSecondThreadLoading = false
                print("fail page: \(thread2Search.page)")
            })
        }
        
    }
    
    func load(_ searchQuery: String, completionHandler: @escaping () -> Void){
        self.search = SearchModel(query: searchQuery, page: 0)
        
        entries = []
        firstThreadResult = []
        secondThreadResult = []
        
        loadNextPage(completionHandler: completionHandler)
    }
}
