//
//  AppDependeciesContainer.swift
//  Github
//
//  Created by Iacopo Pazzaglia on 17/10/2020.
//

import UIKit

class AppDependencyContainer {
    let deepLinkHandler = DeepLinkHandler()
    
    func makeMainViewController() -> UIViewController {
        let oAuthConfig = OAuthConfig(authorizationUrl: AuthConfig.shared.authorizationURL,
                                      tokenUrl: AuthConfig.shared.tokenURL,
                                      clientId: AuthConfig.shared.clientId,
                                      clientSecret: AuthConfig.shared.clientSecret,
                                      redirectUri: AuthConfig.shared.redirect,
                                      scopes: AuthConfig.shared.scopes)
        let oAuthClient = RemoteOAuthClient(config: oAuthConfig, httpClient: HTTPClient())
        let oAuthService = OAuthService(oauthClient: oAuthClient)
        let deepLinkCallback: (DeepLink) -> Void = { deepLink in
            if case .oAuth(let url) = deepLink {
                oAuthService.exchangeCodeForToken(url: url)
            }
        }
        deepLinkHandler.addCallback(deepLinkCallback, forDeepLink: DeepLink(url: AuthConfig.shared.redirect)!)
        let loginVC = LoginViewController(oAuthService: oAuthService)
        let navigationController = UINavigationController(rootViewController: loginVC)
        //navigationController.pushViewController(loginVC, animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        
        
        return navigationController
    }
}
