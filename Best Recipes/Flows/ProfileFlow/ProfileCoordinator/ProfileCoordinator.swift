//
//  ProfileCoordinator.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import Foundation

class ProfileCoordinator: Coordinator {
    
    override func start() {
        print("Init profile screen")
        let vc = ProfileViewController()
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
