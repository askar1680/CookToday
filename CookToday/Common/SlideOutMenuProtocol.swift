//
//  SlideOutMenuProtocol.swift
//  CookToday
//
//  Created by Аскар on 3/5/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

protocol SlideOutMenuProtocol: class {
    var menuViewController: UIViewController { get }
    var controllers: [UIViewController] { get }
    
    var currentViewController: UIViewController? { get set }
    var contentBackgroundView: UIView { get }
    var menuBackgroundView: UIView { get }
    var darkCoverView: UIView { get }
    var contentLeadingConstraint: NSLayoutConstraint? { get set }
    var menuWidth: CGFloat { get }
    var velocityThreshold: CGFloat { get }
    var isMenuOpened: Bool { get set }
    
    var panSelector: Selector { get }
    var darkTapSelector: Selector { get }
    
    func setupSlideOutMenu()
    func handlePan(gesture: UIPanGestureRecognizer)
    func handleDarkTap()
}

// Variable inits
extension SlideOutMenuProtocol {
    var menuWidth: CGFloat { return 300 }
    var velocityThreshold: CGFloat { return 500 }
}

extension SlideOutMenuProtocol where Self: UIViewController {
    func handleDarkTap() {
        closeMenu()
    }
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        print(translation.x)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(x, menuWidth)
        x = max(x, 0)
        contentLeadingConstraint?.constant = x
        
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocityX = gesture.velocity(in: view).x
        if isMenuOpened {
            if abs(velocityX) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            }
            else {
                closeMenu()
            }
        }
        else {
            if velocityX > velocityThreshold {
                openMenu()
                return
            }
            if translation.x < menuWidth / 2 {
                closeMenu()
            }
            else {
                openMenu()
            }
        }
    }
    
    func openMenu() {
        contentLeadingConstraint?.constant = menuWidth
        isMenuOpened = true
        performAnimation()
    }
    
    func closeMenu() {
        contentLeadingConstraint?.constant = 0
        isMenuOpened = false
        performAnimation()
    }
    
    func performCleanUp() {
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()
    }
    
    func performAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
}

extension SlideOutMenuProtocol where Self: UIViewController {
    func setupSlideOutMenu() {
        setupViewControllers()
        addSubviews()
        setViewConstraints()
        stylizeViews()
        setupGestures()
    }
    
    func addSubviews() {
        view.addSubview(contentBackgroundView)
        view.addSubview(menuBackgroundView)
        contentBackgroundView.addSubview(darkCoverView)
    }
    
    func setViewConstraints() {
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentLeadingConstraint = contentBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        contentLeadingConstraint?.isActive = true
        
        menuBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        menuBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuBackgroundView.widthAnchor.constraint(equalToConstant: menuWidth).isActive = true
        menuBackgroundView.trailingAnchor.constraint(
            equalTo: contentBackgroundView.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        
        darkCoverView.translatesAutoresizingMaskIntoConstraints = false
        darkCoverView.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor).isActive = true
        darkCoverView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor).isActive = true
        darkCoverView.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor).isActive = true
        darkCoverView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor).isActive = true
    }
    
    func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: panSelector)
        self.view.addGestureRecognizer(panGesture)
        
        let tapGestureDarkCover = UITapGestureRecognizer(target: self, action: darkTapSelector)
        darkCoverView.addGestureRecognizer(tapGestureDarkCover)
    }
    
    func setupViewControllers() {
        if controllers.isEmpty { fatalError("controllers must not be empty") }
        let firstViewController = controllers[0]
        currentViewController = firstViewController
        
        let firstView = firstViewController.view!
        let menuView = menuViewController.view!
        
        contentBackgroundView.addSubview(firstView)
        menuBackgroundView.addSubview(menuView)
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor).isActive = true
        firstView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor).isActive = true
        firstView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor).isActive = true
        firstView.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor).isActive = true
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.topAnchor.constraint(equalTo: menuBackgroundView.topAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: menuBackgroundView.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: menuBackgroundView.trailingAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: menuBackgroundView.bottomAnchor).isActive = true
        
        addChild(firstViewController)
        addChild(menuViewController)
    }
    
    func stylizeViews() {
        view.backgroundColor = .white
        
        // darkCoverView
        darkCoverView.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        darkCoverView.alpha = 0
        darkCoverView.isUserInteractionEnabled = true
    }
}
