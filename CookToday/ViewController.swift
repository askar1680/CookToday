//
//  ViewController.swift
//  CookToday
//
//  Created by Аскар on 3/5/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        let label = UILabel()
        
        view.addSubview(label)
        label.text = "sadsadasd"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
