//
//  API.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

import Foundation
class API{
    static let shared = API()
    let httpClient = HTTPClient()
    
    func search(_ search: SearchModel, successHandler: @escaping (SearchResponse) -> Void, failureHandler: @escaping (HTTPClient.RequestError) -> Void){
        
        let httpRequest = HttpRequest(baseUrl: URL(string: "https://api.github.com/search/repositories")!,
                                      method: .get,
                                      params: search,
                                      headers: ["Accept": "application/json"])
        self.httpClient.performRequest(request: httpRequest) {
            //_ in
            (result: Result<SearchResponse, HTTPClient.RequestError>) in
            switch result {
            case .success(let response):
                successHandler(response)
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
}
