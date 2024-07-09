//
//  ProfileViewController.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My profile"

        profileView.setDelegate(self)
        
    }
    

   

}

// MARK: - Extensions UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        UITableViewCell()
    }
}
