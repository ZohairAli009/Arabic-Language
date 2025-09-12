//
//  LevelOneCell.swift
//  Arabic-Language
//
//  Created by Zohair on 30/11/2024.
//

import UIKit

class LevelOneCell: UICollectionViewCell {
    
    @IBOutlet var questionViewHeight: NSLayoutConstraint!
    @IBOutlet private var mainViewWidth: NSLayoutConstraint!
    @IBOutlet var questionView: UIView!
    @IBOutlet var optionsStackView: UIStackView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var translationLabel: UILabel!
    @IBOutlet var questionWordLabel: UILabel!
    
    var optionsList: [String] = [] {
        didSet {
            updateOptions()
        }
    }
    var correctOption = ""
    var playSoundKey: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStackView()
        layer.cornerRadius = 15
        playSoundKey = UserDefaults.standard.bool(forKey: "AnswerSound")
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
            optionBtn.titleLabel?.textAlignment = .center
            optionBtn.setTitle(option, for: .normal)
            optionBtn.setTitleColor(.label, for: .normal)
            optionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .regular)
            optionBtn.addTarget(self, action: #selector(optionBtnTapped), for: .touchUpInside)
            optionsStackView.addArrangedSubview(optionBtn)
        }
    }
    
    
    private func playSound(ofType: String){
        guard playSoundKey else { return }
        if playSoundKey{
            guard let soundURL = Bundle.main.url(forResource: ofType, withExtension: "mp3") else { return }
            CodeHelper.playSound(soundUrl: soundURL)
        }else{ return }
    }
    
   
    @objc private func optionBtnTapped(_ sender: UIButton) {
        optionsStackView.isUserInteractionEnabled = false
        let selectedIndex = sender.tag
        let selectedOption = optionsList[selectedIndex]
        
        if selectedOption == correctOption{
            sender.backgroundColor = .systemGreen.withAlphaComponent(0.85)
            playSound(ofType: "CorrectAns")
            CodeHelper.speakEnglishWord(word: selectedOption)
        }else{
            sender.backgroundColor = .systemRed.withAlphaComponent(0.8)
            playSound(ofType: "WorngAns")
            // save wrong answer
            let dict = [questionWordLabel.text!: correctOption]
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
