//
//  WordsTableViewCell.swift
//  Arabic-Language
//
//  Created by Zohair on 16/12/2024.
//

import UIKit

class WordsTableViewCell: UITableViewCell {
    
    @IBOutlet var arabicLabel: UILabel!
    @IBOutlet var englishLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func speakBtnTap(_ sender: Any) {
        if let speakWord = arabicLabel.text {
            CodeHelper.speakArabicWord(word: speakWord, speech: "fast")
        }
    }
    
}
