//
//  SceneDelegate.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 29.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = RecipeViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
//        let appCoordinator = AppCoordinator(
//            type: .onboarding,
//            navigationController: navigationController
//        )
//        self.coordinator = appCoordinator
//        appCoordinator.start()
    }
}
