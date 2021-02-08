//
//  RepositoriesLoader.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

import Foundation


class RepositoryLoader{
    var entries: [Repository] = []
    
    func load(_ searchQuery: String, page: Int = 1, completionHandler: @escaping () -> Void){
        let search = SearchModel(query: searchQuery, page: page)
        API.shared.search(search, successHandler: {searchResponse in
            self.entries = searchResponse.items
            completionHandler()
        }, failureHandler: {requestError in
            self.entries = []
            completionHandler()
        })
    }
}
