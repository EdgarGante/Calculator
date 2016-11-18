//
//  MaterialView.swift
//  calculator
//
//  Created by Edgar on 11/17/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import UIKit

class MaterialView: UIView {
    
    //MARK: Properties
    
    //Color
    let deepBlue = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.50).cgColor
    
    override func awakeFromNib() {
        layer.shadowColor = deepBlue
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 14
        layer.shouldRasterize = true
    }
}
