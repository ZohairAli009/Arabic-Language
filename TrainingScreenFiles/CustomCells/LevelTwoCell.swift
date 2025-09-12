//
//  LevelTwoCell.swift
//  Arabic-Language
//
//  Created by Zohair on 04/12/2024.
//

import UIKit

class LevelTwoCell: UICollectionViewCell {
    
    @IBOutlet var optionsStackView: UIStackView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet private var mainViewWidth: NSLayoutConstraint!
    
    var optionsList: [String] = [] {
        didSet {
            updateOptions()
        }
    }
    var correctOption = ""
    private var answerSoundKey: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStackView()
        layer.cornerRadius = 15
        answerSoundKey = UserDefaults.standard.bool(forKey: "AnswerSound")
    }
    
    private func setupStackView() {
        optionsStackView.spacing = 0.5
        optionsStackView.distribution = .fillEqually
        optionsStackView.axis = .vertical
    }
    
    private func updateOptions() {
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, option) in optionsList.enumerated() {
            let optionBtn = UIButton()
            optionBtn.backgroundColor = UIColor(named: "Color-5")
            optionBtn.tag = index
            optionBtn.titleLabel?.numberOfLines = 2
            optionBtn.titleLabel?.textAlignment = .center
            optionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .regular)
            optionBtn.addTarget(self, action: #selector(optionBtnTap), for: .touchUpInside)
            
            let attributedString = UIHelper.addAttributedString(to: option)
            optionBtn.setAttributedTitle(attributedString, for: .normal)
            
            optionsStackView.addArrangedSubview(optionBtn)
        }
    }
    
    private func playSound(ofType: String){
        guard answerSoundKey else { return }
        if answerSoundKey{
            guard let soundURL = Bundle.main.url(forResource: ofType, withExtension: "mp3") else { return }
            CodeHelper.playSound(soundUrl: soundURL)
        }else{ return }
    }
   
    @objc private func optionBtnTap(_ sender: UIButton) {
        optionsStackView.isUserInteractionEnabled = false
        let selectedIndex = sender.tag
        let selectedOption = optionsList[selectedIndex]
        
        if selectedOption == correctOption{
            sender.backgroundColor = .systemGreen.withAlphaComponent(0.85)
            playSound(ofType: "CorrectAns")
            CodeHelper.speakArabicWord(word: selectedOption, speech: "fast")
        }else{
            sender.backgroundColor = .systemRed.withAlphaComponent(0.8)
            playSound(ofType: "WorngAns")
            // save wrong answer
            let dict = [correctOption: questionLabel.text!]
            let newData = ProgressData(alreadyKnown: [:], difficult: dict, progressByCategory: [:])
            userDefaults.updateProgressData(data: newData, 0)
        }
        NotificationCenter.default.post(name: NSNotification.Name("optionBtnTap"), object: nil)
    }

    func setCellWidth(view: UIView){
        let screenWidth = view.frame.width
        let width = screenWidth - 73
        self.frame.size.width = width
        mainViewWidth.constant = width
    }
}
