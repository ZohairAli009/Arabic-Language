//
//  Word'sMoreInfoViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 07/02/2025.
//

import UIKit

class WordsMoreInfoViewController: UIViewController {

    @IBOutlet var fastSpeak: UIButton!
    @IBOutlet var slowSpeak: UIButton!
    @IBOutlet var arabicLabel: UILabel!
    @IBOutlet var englishLabel: UILabel!
    @IBOutlet var infoView: UIView!
    
    var wordInfo: Word!
    var infoDict: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skyBlue = CodeHelper.valuesToUIColor(values: [83, 173, 240])
        fastSpeak.layer.borderWidth = 1.5
        slowSpeak.layer.borderWidth = 1
        fastSpeak.layer.borderColor = skyBlue.cgColor
        slowSpeak.layer.borderColor = skyBlue.cgColor
        
        arabicLabel.text = wordInfo.arabic
        englishLabel.text = wordInfo.english
        
        infoDict = ["Part of speech: ": wordInfo.part_of_speech,
                    "Singular: ": wordInfo.singular,
                    "Plural: ": wordInfo.plural,
                    "Synonyms: ": wordInfo.synonyms,
                    "Usage: ": wordInfo.grammar_info.usage,
                    "Grammer: ": wordInfo.grammar_info.sentence_position]
        
        let byOrderDic = infoDict.sorted {$0.key < $1.key}
        var yPosition = 0
        
        for item in byOrderDic{
            let view = WordsMoreInfoView()
            view.titleLabel.text = item.key
            if type(of: item.value) == String.self{
                let value = item.value as! String
                if value.isEmpty{ view.infoLabel.text = "No \(item.key)" }
                else{ view.infoLabel.text = value }
            }
            else if type(of: item.value) == [String].self{
                let value = item.value as! [String]
                if value.isEmpty{ view.infoLabel.text = "No \(item.key)" }
                else{ view.infoLabel.text = "\(value.joined(separator: " ,"))" }
            }
            infoView.addSubview(view)
            
            view.frame = CGRect(x: 0, y: yPosition, width: Int(infoView.frame.width), height: 60)
            yPosition += Int(view.frame.height) + 10
        }
        
    }
    
    
    
    
    @IBAction func speakBtnTapped(_ sender: UIButton) {
        if sender.tag == 1{
            CodeHelper.speakArabicWord(word: wordInfo.arabic, speech: "slow")
        }
        else if sender.tag == 2{
            CodeHelper.speakArabicWord(word: wordInfo.arabic, speech: "fast")
        }
    }
    
    
}
