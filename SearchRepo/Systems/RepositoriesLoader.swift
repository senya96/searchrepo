//
//  RepositoriesLoader.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

import Foundation


class RepositoryLoader{
    var entries: [Repository] = []
    var search: SearchModel?
    var canLoadNext = true
    var per_page = 30
    var isLoading = false
    
    func loadNextPage(completionHandler: @escaping () -> Void){
        isLoading = true
        self.search?.page += 1
        API.shared.search(self.search!, successHandler: {searchResponse in
            self.isLoading = false
            self.entries += searchResponse.items
            self.canLoadNext = searchResponse.totalCount != self.entries.count
            completionHandler()
        }, failureHandler: {requestError in
            self.isLoading = false
            completionHandler()
        })
    }
    
    func load(_ searchQuery: String, completionHandler: @escaping () -> Void){
        self.isLoading = true
        self.search = SearchModel(query: searchQuery, page: 1)
        API.shared.search(self.search!, successHandler: {searchResponse in
            self.isLoading = false
            self.entries = searchResponse.items
            self.canLoadNext = searchResponse.totalCount != self.entries.count
            completionHandler()
        }, failureHandler: {requestError in
            self.isLoading = false
            self.entries = []
            completionHandler()
        })
    }
}
