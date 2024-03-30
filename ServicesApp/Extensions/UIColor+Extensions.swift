//
//  UIColor+Extensions.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 31.03.2024.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat){
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
