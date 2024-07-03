//
//  OnboardingCoordinator.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import Foundation

class OnboardingCoordinator: Coordinator {
    
    override func start() {
        print("Start onboarding")
        showOnboarding()
    }
    
    override func finish() {
        finishDelegate?.coordinatorDidFinished(childCoordinator: self)
    }
}

private extension OnboardingCoordinator {
    func showOnboarding() {
        let vc = AppFactory.makeOnboardingScene(coordinator: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}
