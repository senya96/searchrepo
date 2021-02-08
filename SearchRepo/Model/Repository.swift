//
//  Repository.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 08.02.2021.
//



struct Repository: Decodable{
    let full_name: String
    let description: String?
    let stargazers_count: Int
    let html_url: String
    
    func getShortDescription(_ numOfCharacters: Int = 100) -> String?{
        guard let description = self.description else { return nil }
        if description.count > numOfCharacters{
            let lastIndex = description.index(description.startIndex, offsetBy: 100)
            let substr = String(description[description.startIndex...lastIndex])
            return "\(substr)..."
        }
        return description
    }
}
