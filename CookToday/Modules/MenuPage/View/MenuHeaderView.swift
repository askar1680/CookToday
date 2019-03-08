//
//  MenuHeaderView.swift
//  CookToday
//
//  Created by Аскар on 3/7/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView, ViewInstaller {
    
    let stackView = UIStackView()
    let usernameLabel = UILabel()
    let nameLabel = UILabel()
    let statsLabel = UILabel()
    let profileImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupStatsAttributedText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStatsAttributedText() {
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
        attributedText.append(NSAttributedString(string: "following  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "123 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "followers", attributes: [.foregroundColor: UIColor.black]))
        statsLabel.attributedText = attributedText
    }
    
    func addSubviews() {
        addSubview(stackView)
        let arrangedSubviews = [
            UIStackView(arrangedSubviews: [profileImageView, UIView()]),
            UIView(),
            nameLabel,
            usernameLabel,
            SpacerView(space: 12),
            statsLabel
        ]
        for view in arrangedSubviews {
            stackView.addArrangedSubview(view)
        }
    }
    
    func setViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    func stylizeViews() {
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        nameLabel.text = "Lilly"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        usernameLabel.text = "@lilly.james"
        
        profileImageView.image = UIImage(named: "girl_profile")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .red
    }
}

