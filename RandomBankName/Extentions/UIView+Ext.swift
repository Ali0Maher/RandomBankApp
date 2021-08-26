//
//  UIView+Ext.swift
//  RandomBankName
//
//  Created by Ali on 8/26/21.
//

import UIKit


extension UIView {
    public func addViewShadow(color: UIColor = .lightGray, opacity: Float = 0.5, radius: CGFloat = 2) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)

    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.bounds
     
        gradientLayer.colors = [UIColor.orange.cgColor,#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor, #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).cgColor]
     
        self.layer.addSublayer(gradientLayer)
    }
}



