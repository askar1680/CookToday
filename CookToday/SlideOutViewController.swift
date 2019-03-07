//
//  SlideOutViewController.swift
//  CookToday
//
//  Created by Аскар on 3/5/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SlideOutViewController: UIViewController, SlideOutMenuProtocol {
    
    var menuViewController: UIViewController = MenuViewController()
    
    var controllers: [UIViewController] = []
    
    var panSelector: Selector = #selector(handlePanGesture(gesture:))
    var darkTapSelector: Selector = #selector(handleDarkTapGesture(gesture:))
    
    var currentViewController: UIViewController?
    
    var contentBackgroundView = UIView()
    var menuBackgroundView = UIView()
    var darkCoverView = UIView()
    
    var contentLeadingConstraint: NSLayoutConstraint?
    
    var isMenuOpened: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = UIViewController()
        viewController.title = "view"
        controllers.append(UINavigationController(rootViewController: viewController))
        
        setupSlideOutMenu()
    }
}

extension SlideOutViewController {
    
    @objc func handleDarkTapGesture(gesture: UITapGestureRecognizer) {
        handleDarkTap()
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        handlePan(gesture: gesture)
    }
}
