//
//  SpacerView.swift
//  CookToday
//
//  Created by Аскар on 3/7/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SpacerView: UIView {
    
    var space: CGFloat
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }
    
}
