//
//  NotificationCoordinator.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import Foundation

class NotificationCoordinator: Coordinator {
    
    override func start() {
        print("Init notification screen")
        let vc = NotificationViewController()
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
