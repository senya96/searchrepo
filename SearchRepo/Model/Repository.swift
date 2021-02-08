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
}
