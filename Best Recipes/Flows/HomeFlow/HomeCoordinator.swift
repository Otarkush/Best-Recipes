//
//  HomeCoordinator.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import Foundation

class HomeCoordinator: Coordinator {
    
    override func start() {
        print("Init home screen")
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
