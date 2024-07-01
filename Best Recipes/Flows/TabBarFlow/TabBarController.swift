//
//  TabBarController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        tabBarControllers.forEach { item in
            self.addChild(item)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
    }
    
}
