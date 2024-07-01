//
//  ViewController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 29.06.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

// MARK: - Prewiew for UIKIT
@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout, body: {
    ViewController()
})
