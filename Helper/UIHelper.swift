//
//  UIHelper.swift
//  Arabic-Language
//
//  Created by Zohair on 04/12/2024.
//

import UIKit


struct UIHelper {
    
    static func addAttributedString(to str: String) -> NSMutableAttributedString{
        let phonetic = CodeHelper.translateArabicWord(str)
        let title = "\(phonetic)\n\(str)"
        let newlineIndex = title.firstIndex(of: "\n")
        let topRange = NSRange(title.startIndex..<newlineIndex!, in: title)
        let bottomRange = NSRange(title.index(after: newlineIndex!)..<title.endIndex, in: title)
        
        let attributedTitle = NSMutableAttributedString(string: title)
        // Customize the top title
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.secondaryLabel, range: topRange)
        attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .regular), range: topRange)

        // Customize the bottom title
        attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 25, weight: .regular), range: bottomRange) // "Bottom Title"

        return attributedTitle
    }
    
}
