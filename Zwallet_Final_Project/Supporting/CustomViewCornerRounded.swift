//
//  CustomViewCornerRounded.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit

class CustomViewCornerRounded: UIView {
    
    @IBInspectable
    
    var cornerRadius: CGFloat = 0 {
        didSet{
            update()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    
    func update() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
}
