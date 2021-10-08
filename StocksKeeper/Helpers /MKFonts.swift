//
//  MKFonts.swift
//  StocksKeeper
//
//  Created by dev on 6.10.21.
//

import UIKit

extension UIFont {
    static func robotoBold(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Bold", size: size)
    }
    
    static func robotoMedium(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Medium", size: size)
    }
    
    static func robotoItalic(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-ThinItalic", size: size)
    }
}
