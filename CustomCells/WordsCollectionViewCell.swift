//
//  WordsCollectionViewCell.swift
//  Arabic-Language
//
//  Created by Zohair on 28/11/2024.
//

import UIKit

class WordsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var phoneticWordLabel: UILabel!
    @IBOutlet var arabicWordLabel: UILabel!
    @IBOutlet var englishWordLabel: UILabel!
    @IBOutlet var speakBtn: UIButton!
    @IBOutlet var slowSpeakBtn: UIButton!
    @IBOutlet var alreadyKnowBtn: UIButton!
    @IBOutlet var learnBtn: UIButton!
    @IBOutlet var actionLabel: UILabel!
    @IBOutlet var mainViewHeight: NSLayoutConstraint!
    @IBOutlet var mainViewWidth: NSLayoutConstraint!
    
    var moreInfoBtnAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    
    private func configure(){
        let skyBlue = CodeHelper.valuesToUIColor(values: [83, 173, 240])
        let peach = CodeHelper.valuesToUIColor(values: [255, 182, 18])
        
        speakBtn.layer.borderWidth = 2
        speakBtn.layer.borderColor = skyBlue.cgColor
        slowSpeakBtn.layer.borderWidth = 1
        slowSpeakBtn.layer.borderColor = skyBlue.cgColor
        alreadyKnowBtn.layer.borderWidth = 1.6
        alreadyKnowBtn.layer.borderColor = UIColor.systemGreen.cgColor
        learnBtn.backgroundColor = peach
        speakBtn.tag = 1
        slowSpeakBtn.tag = 2
            
        speakBtn.addTarget(self, action: #selector(speakBtnTapped), for: .touchUpInside)
        slowSpeakBtn.addTarget(self, action: #selector(speakBtnTapped), for: .touchUpInside)
        
        alreadyKnowBtn.addTarget(self, action: #selector(alreadyKnowBtnTap), for: .touchUpInside)
        learnBtn.addTarget(self, action: #selector(learnBtnTapped), for: .touchUpInside)
        layer.cornerRadius = 15 
    }
    
    
    func setActionLabelText(_ type: String){
        if type == "already"{
            actionLabel.text = "Already know"
            actionLabel.textColor = .systemGreen
        }else{
            actionLabel.text = "In progress"
            actionLabel.textColor = CodeHelper.valuesToUIColor(values: [255, 182, 18])
        }
    }
    
    
    @objc func alreadyKnowBtnTap(){
        NotificationCenter.default.post(name: NSNotification.Name("ActionBtnsTapped"), object: [arabicWordLabel.text, englishWordLabel.text, "already"])
    }
    
    
    @objc func learnBtnTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("ActionBtnsTapped"), object: [arabicWordLabel.text, englishWordLabel.text, "learn"])
    }
    
    
    @objc func speakBtnTapped(_ sender: UIButton){
        if sender.tag == 1{
            CodeHelper.speakArabicWord(word: arabicWordLabel.text!, speech: "fast")
        }
        else if sender.tag == 2{
            CodeHelper.speakArabicWord(word: arabicWordLabel.text!, speech: "slow")
        }
    }
    
    @IBAction func moreInfoBtnTapped(_ sender: Any) {
        moreInfoBtnAction?()
    }
    
    func setCellWidth(view: UIView){
        let screenWidth = view.frame.width
        let width = screenWidth - 73
        self.frame.size.width = width
        mainViewWidth.constant = width
    }

}
