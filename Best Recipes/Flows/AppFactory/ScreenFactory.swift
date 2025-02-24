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
        homeNavigationController.navigationBar.isHidden = true
        homeNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: Resources.Images.TabBar.home,
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
        favoriteNavigationController.navigationBar.isHidden = true
        favoriteNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: Resources.Images.TabBar.bookmark,
            tag: 1
        )
        let favoriteCoordinator = FavoriteCoordinator(
            type: .favorite,
            navigationController: favoriteNavigationController
        )
        favoriteCoordinator.finishDelegate = finishDelegate
        favoriteCoordinator.start()
        
        // MARK: - Spacer
        let addRecipeNavigationController = UINavigationController()
        addRecipeNavigationController.navigationBar.isHidden = true
        addRecipeNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: nil,
            tag: 3
        )
        let addRecipeCoordinator = AddRecipeCoordinator(
            type: .addRecipe,
            navigationController: addRecipeNavigationController
        )
        addRecipeCoordinator.finishDelegate = finishDelegate
        addRecipeCoordinator.start()
        
        // MARK: - Влкадка notification
        let notificationNavigationController = UINavigationController()
        notificationNavigationController.navigationBar.isHidden = true
        notificationNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: Resources.Images.TabBar.notification,
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
        profileNavigationController.navigationBar.isHidden = true
        profileNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: Resources.Images.TabBar.profile,
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
        coordinator.addChildCoordinator(addRecipeCoordinator)
        coordinator.addChildCoordinator(notificationCoordinator)
        coordinator.addChildCoordinator(profileCoordinator)
        
        let tabbarControllers = [
            homeNavigationController,
            favoriteNavigationController,
            addRecipeNavigationController,
            notificationNavigationController,
            profileNavigationController
        ]
        let tabbar = TabBarController(tabBarControllers: tabbarControllers)
        return tabbar
    }
}
