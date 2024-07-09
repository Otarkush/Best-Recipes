//
//  ProfileView.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 09.07.2024.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    // MARK: - Properties UI
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.alignment = .trailing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var provileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10 // сделать потом с учетом view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.black
        label.font = Resources.Fonts.poppinsBold(of: 24)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "My recipes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    // MARK: - Setup UI
    
    private func setView() {
        backgroundColor = .white
        
    }
    
    func setDelegate(_ value: ProfileViewController) {
        profileTableView.delegate = value
        profileTableView.dataSource = value
    }
    
}
