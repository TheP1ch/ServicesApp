//
//  UILabel+Extensions.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 29.03.2024.
//

import UIKit

extension UILabel {
    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor){
        self.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
    }
}
