//
//  Auth.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//
import UIKit

struct AuthConfig{
    static let shared = AuthConfig()
    
    let clientSecret = "84ff183040dda6cf9ea264fdff39858142ff8c57"
    let redirect = URL(string: "com.serhiinasinnyk.searchrepo://authentication")!
    let clientId = "e77a84e9441cd3893092"
    let tokenURL = URL(string: "https://github.com/login/oauth/access_token")!
    let authorizationURL = URL(string: "https://github.com/login/oauth/authorize")!
    let scopes = ["repo", "user"]
}
