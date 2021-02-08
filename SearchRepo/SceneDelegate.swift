//
//  SceneDelegate.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 06.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let dependencyContainer = AppDependencyContainer()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let mainVC = dependencyContainer.makeMainViewController()
        self.window = window
        window.frame = UIScreen.main.bounds
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let urlContext = URLContexts.first {
            let url = urlContext.url
            if let deepLink = DeepLink(url: url) {
                dependencyContainer.deepLinkHandler.handleDeepLinkIfPossible(deepLink: deepLink)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        CoreDataManager.sharedInstance.saveContext()
    }
}

