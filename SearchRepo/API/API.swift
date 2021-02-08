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
    
    func setAuthorizationToken(_ token: String){
        headers["Authorization"] = "token \(token)"
    }
    
    var headers: [String: String] = [
        "Accept": "application/json"
      ]
    
    func search(_ search: SearchModel, successHandler: @escaping (SearchResponse) -> Void, failureHandler: @escaping (HTTPClient.RequestError) -> Void){
        
        let httpRequest = HttpRequest(baseUrl: URL(string: "https://api.github.com/search/repositories")!,
                                      method: .get,
                                      params: search,
                                      headers: headers)
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
