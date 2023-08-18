//
//  Extension.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIButton {
  func imageToRight() {
      transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
      titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
      imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
  }
}
