//
//  letterDetailViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 11/12/2024.
//

import UIKit

class letterDetailViewController: UIViewController {
    
    @IBOutlet var variationLabel: UILabel!
    @IBOutlet var letterLabel: UILabel!
    @IBOutlet var fastSpeakBtn: UIButton!
    @IBOutlet var slowSpeakBtn: UIButton!
    @IBOutlet var translationLabel: UILabel!
    @IBOutlet var letterVariationStack: UIStackView!
    @IBOutlet var continueBtnTopAnchor: NSLayoutConstraint!
    
    var alphabet: String!
    var translation: String!
    var letterVariations: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupStackView()
    }
    
    
    init(number: String, translation: String) {
        super.init(nibName: nil, bundle: nil)
        self.alphabet = number
        self.translation = translation
    }
    
    
    init(alphabet: String, translation: String, variations: ArabicLetters.Forms){
        super.init(nibName: nil, bundle: nil)
        self.alphabet = alphabet
        self.translation = translation
        self.letterVariations = [variations.final, variations.medial, variations.initial]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView(){
        let variationsName = ["final", "medial", "initial"]
        guard let variations = letterVariations else { return }
        for i in 0...2{
            let View = letterVariationView()
            View.label_1.text = variations[i]
            View.label_2.text = variationsName[i]
            letterVariationStack.addArrangedSubview(View)
        }
    }
    
    
    private func configure(){
        letterLabel.text = alphabet
        translationLabel.text = translation
        slowSpeakBtn.layer.borderWidth = 1
        slowSpeakBtn.layer.borderColor = UIColor.tintColor.cgColor
        fastSpeakBtn.layer.borderWidth = 1
        fastSpeakBtn.layer.borderColor = UIColor.tintColor.cgColor
        
        guard letterVariations != nil else {
            letterVariationStack.isHidden = true
            variationLabel.isHidden = true
            continueBtnTopAnchor.constant = 25
            return
        }
    }
    
    @IBAction func speakBtnsTapped(_ sender: UIButton) {
        guard let speakWord = letterLabel.text else { return }
        if sender.tag == 1{
            CodeHelper.speakArabicWord(word: speakWord, speech: "slow")
        }else{
            CodeHelper.speakArabicWord(word: speakWord, speech: "fast")
        }
    }
    
    @IBAction func continueBtnTap(_ sender: Any) {
        dismiss(animated: true)
    }
}
