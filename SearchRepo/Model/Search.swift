//
//  SearchModel.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

struct SearchModel: Encodable{
    let query: String
    var page: Int = 0
    var sort: String = "stars"
    var order: String = "desc"
    
    private enum CodingKeys: String, CodingKey {
        case query = "q"
        case page = "page"
        case sort = "sort"
        case order = "order"
    }
}

struct SearchResponse: Decodable{
    let totalCount: Int
    let incomplete_results: Bool
    let items: [Repository]
    
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incomplete_results
        case items
    }
}
