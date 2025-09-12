//
//  AlreadyKnownWordCell.swift
//  Arabic-Language
//
//  Created by Zohair on 16/12/2024.
//

import UIKit

class AlreadyKnownWordCell: UICollectionViewCell {
    
    @IBOutlet var transLabel: UILabel!
    @IBOutlet var arabicLabel: UILabel!
    @IBOutlet var englishLabel: UILabel!
    @IBOutlet var repeatBtn: UIButton!
    @IBOutlet var speakBtn1: UIButton!
    @IBOutlet var speakBtn2: UIButton!
    @IBOutlet var repeatedView: UIView!
    
    var cancelBtnAction: (() -> Void)!
    var repeatBtnAction: (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    
    private func configure(){
        self.layer.cornerRadius = 15
        let skyBlue = CodeHelper.valuesToUIColor(values: [83, 173, 240])
        
        speakBtn1.layer.borderWidth = 1
        speakBtn1.layer.borderColor = skyBlue.cgColor
        speakBtn2.layer.borderWidth = 2
        speakBtn2.layer.borderColor = skyBlue.cgColor
        repeatBtn.layer.borderWidth = 1.6
        repeatBtn.layer.borderColor = UIColor.systemGreen.cgColor
    }

    @IBAction func repeatBtnTapped(_ sender: UIButton) {
        if sender.tag == 1{
            cancelBtnAction()
        }
        else if sender.tag == 2{
            sender.isHidden = true
            repeatedView.isHidden = false
            repeatBtnAction()
        }
    }
    
    @IBAction func speakBtnsTap(_ sender: UIButton) {
        guard let word = arabicLabel.text else { return }
        if sender.tag == 3{
            CodeHelper.speakArabicWord(word: word, speech: "slow")
        }
        else if sender.tag == 4{
            CodeHelper.speakArabicWord(word: word, speech: "fast")
        }
    }
    
}
