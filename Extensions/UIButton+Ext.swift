//
//  UIButton+Ext.swift
//  Arabic-Language
//
//  Created by Zohair on 23/11/2024.
//

import UIKit


extension UIButton{
    
    func addImage(sfSymbol: String, tintColor: UIColor, size: CGFloat){
        self.setImage(UIImage(systemName: sfSymbol, withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: .medium)), for: .normal)
        self.tintColor = tintColor
    }
}


extension String {
    func removingPunctuation() -> String {
        return self.components(separatedBy: .punctuationCharacters).joined()
    }
}
