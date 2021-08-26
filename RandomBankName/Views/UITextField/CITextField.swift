//
//  CITextField.swift
//  RandomBankName
//
//  Created by Ali on 8/26/21.
//

import UIKit

class CITextField: UITextField {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9489166141, green: 0.9490789771, blue: 0.9489063621, alpha: 1)
        layer.cornerRadius = 20
        doneAccessory = true
        
        addViewShadow()
    }
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
