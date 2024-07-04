//
//  ScreenFactory.swift
//  Best Recipes
//
//  Created by dsm 5e on 02.07.2024.
//

import UIKit

struct AppFactory {
    
    static func makeOnboardingScene(coordinator: OnboardingCoordinator) -> OnboardingPageViewController {
        return OnboardingPageViewController(coordinator: coordinator)
    }
    
    static func makeOnboardingFlow(
        coordinator: AppCoordinator,
        navigationController: UINavigationController,
        finishDelegate: CoordinatorFinishDelegate
    ) {
        let onboardingCoordinator = OnboardingCoordinator(
            type: .onboarding,
            navigationController: navigationController,
            finishDelegate: finishDelegate
        )
        coordinator.addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    static func makeTabBarFlow(coordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate) -> TabBarController {
        // MARK: - Вкладка home
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )
        let homeCoordinator = HomeCoordinator(
            type: .home,
            navigationController: homeNavigationController
        )
        homeCoordinator.finishDelegate = finishDelegate
        homeCoordinator.start()
        
        // MARK: - Вкладка favorite
        let favoriteNavigationController = UINavigationController()
        favoriteNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "bookmark"),
            tag: 1
        )
        let favoriteCoordinator = FavoriteCoordinator(
            type: .favorite,
            navigationController: favoriteNavigationController
        )
        favoriteCoordinator.finishDelegate = finishDelegate
        favoriteCoordinator.start()
        
        // MARK: - Spacer
        let spacer = UINavigationController()
        spacer.tabBarItem = UITabBarItem(
            title: nil,
            image: nil,
            tag: 3
        )
        
        // MARK: - Влкадка notification
        let notificationNavigationController = UINavigationController()
        notificationNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "bell"),
            tag: 4
        )
        let notificationCoordinator = NotificationCoordinator(
            type: .notification,
            navigationController: notificationNavigationController
        )
        notificationCoordinator.finishDelegate = finishDelegate
        notificationCoordinator.start()
        
        // MARK: - Вкладка profile
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person"),
            tag: 5
        )
        let profileCoordinator = ProfileCoordinator(
            type: .profile,
            navigationController: profileNavigationController
        )
        profileCoordinator.finishDelegate = finishDelegate
        profileCoordinator.start()
        
        coordinator.addChildCoordinator(homeCoordinator)
        coordinator.addChildCoordinator(favoriteCoordinator)
        coordinator.addChildCoordinator(notificationCoordinator)
        coordinator.addChildCoordinator(profileCoordinator)
        
        let tabbarControllers = [
            homeNavigationController,
            favoriteNavigationController,
            spacer,
            notificationNavigationController,
            profileNavigationController
        ]
        let tabbar = TabBarController(tabBarControllers: tabbarControllers)
        return tabbar
    }
}
