//
//  AppCoordinator.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import UIKit

class AppCoordinator: Coordinator, CoordinatorFinishDelegate {
    
    var window: UIWindow?
    private let userDefaultService = UserDefaultsService.shared
    
    override func start() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        self.navigationController = navigationController
        userDefaultService.isOnboarding ? showTabbarFlow() : showOnboardingFlow()
    }

    override func finish() {
        print("AppCoordinator finish")
    }
}

//MARK: - Navigation Mehtod
private extension AppCoordinator {
    // MARK: - флоу онбординга
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        AppFactory.makeOnboardingFlow(
            coordinator: self,
            navigationController: navigationController,
            finishDelegate: self
        )
    }
    
    // MARK: - мейн флоу с таббаром
    func showTabbarFlow() {
        guard let navigationController = navigationController else { return }
        let tabbar = AppFactory.makeTabBarFlow(
            coordinator: self,
            finishDelegate: self
        )
        navigationController.pushViewController(tabbar, animated: true)
    }
}

extension AppCoordinator {
    func coordinatorDidFinished(childCoordinator: CoordinatorProtocol) {
        remove(childCoordinator)
        switch childCoordinator.type {
        case .onboarding:
            navigationController?.viewControllers.removeAll()
            showTabbarFlow()
        default: 
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
