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
        stack.alignment = .leading
        stack.axis = .vertical
        stack.backgroundColor = .systemGray
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.black
        label.font = Resources.Fonts.poppinsBold(of: 24)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .red
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
        setConstraints()
    }
    
    // MARK: - Setup UI
    
    private func setView() {
        backgroundColor = .white
        
        self.addSubview(mainStack)
        
        mainStack.addArrangedSubview(profileImageView)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(profileTableView)
        
        titleLabel.text = "My recipes"
        profileImageView.image = UIImage(named: "author")
    }
    
    func setDelegate(_ value: ProfileViewController) {
        profileTableView.delegate = value
        profileTableView.dataSource = value
    }
}

// MARK: - Extensions Constraints

extension ProfileView {
    func setConstraints() {
        
        mainStack.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(mainStack)
            make.leading.equalTo(mainStack).offset(20)
            make.size.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mainStack).inset(40)
        }
        
        profileTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(mainStack).offset(-10)
        }
        
    }
}
