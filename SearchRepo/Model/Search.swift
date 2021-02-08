//
//  SearchModel.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

struct SearchModel: Encodable{
    let query: String
    var page: Int = 0
    var per_page: Int = 30
    var sort: String = "stars"
    var order: String = "desc"
    
    init(query: String, page: Int = 0, per_page: Int = 30){
        self.query = query
        self.page = page
        self.per_page = per_page
        
        assert(per_page % 2 == 0)
    }
    
    private enum CodingKeys: String, CodingKey {
        case query = "q"
        case page = "page"
        case sort = "sort"
        case order = "order"
        case per_page = "per_page"
    }
}

struct SearchResponse: Decodable{
    let totalCount: Int
    let incomplete_results: Bool
    let items: [RepositoryModel]
    
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incomplete_results
        case items
    }
}
