//
//  ViewInstaller.swift
//  CookToday
//
//  Created by Аскар on 3/5/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

protocol ViewInstaller {
    func setupViews()
    func addSubviews()
    func setViewConstraints()
    func stylizeViews()
}

extension ViewInstaller {
    func setupViews() {
        addSubviews()
        setViewConstraints()
        stylizeViews()
    }
}
