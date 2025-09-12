//
//  GiveClueUIView.swift
//  Arabic-Language
//
//  Created by Zohair on 06/12/2024.
//

import UIKit

class GiveClueUIView: UIView {
    
    let smallView = UIView()
    let phoneticLabel = UILabel()
    let wordLabel = UILabel()
    let fastButton = UIButton()
    let slowButton = UIButton()
    let cancelButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black.withAlphaComponent(0.7)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubview(smallView)
        smallView.addSubview(phoneticLabel)
        smallView.addSubview(wordLabel)
        smallView.addSubview(fastButton)
        smallView.addSubview(slowButton)
        smallView.addSubview(cancelButton)
        
        smallView.translatesAutoresizingMaskIntoConstraints = false
        phoneticLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        fastButton.translatesAutoresizingMaskIntoConstraints = false
        slowButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        let skyBlue = CodeHelper.valuesToUIColor(values: [83, 173, 240])
        
        // small view
        smallView.backgroundColor = UIColor(named: "Color-1")
        smallView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            smallView.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            smallView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            smallView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            smallView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        // Cancel button
        cancelButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelBtnTap), for: .touchUpInside)
        cancelButton.tintColor = .label
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: smallView.topAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: smallView.trailingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 50),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        // PhoneticLabel
        phoneticLabel.textAlignment = .center
        phoneticLabel.textColor = .secondaryLabel
        phoneticLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        phoneticLabel.text = "[ana bkhir]"
        NSLayoutConstraint.activate([
            phoneticLabel.topAnchor.constraint(equalTo: smallView.topAnchor, constant: 70),
            phoneticLabel.leadingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: 30),
            phoneticLabel.trailingAnchor.constraint(equalTo: smallView.trailingAnchor, constant: -30),
            phoneticLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // WordLabel
        wordLabel.textAlignment = .center
        wordLabel.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        wordLabel.text = "أنا بخير"
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: phoneticLabel.bottomAnchor),
            wordLabel.leadingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: 30),
            wordLabel.trailingAnchor.constraint(equalTo: smallView.trailingAnchor, constant: -30),
            wordLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // SlowSpeak button
        slowButton.tintColor = skyBlue
        slowButton.layer.cornerRadius = 25
        slowButton.layer.borderWidth = 1
        slowButton.layer.borderColor = skyBlue.cgColor
        slowButton.setImage(UIImage(systemName: "tortoise.fill"), for: .normal)
        slowButton.addTarget(self, action: #selector(slowSpeakBtnTap), for: .touchUpInside)
        NSLayoutConstraint.activate([
            slowButton.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 20),
            slowButton.trailingAnchor.constraint(equalTo: fastButton.leadingAnchor,constant: -12),
            slowButton.widthAnchor.constraint(equalToConstant: 50),
            slowButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // FastSpeak button
        fastButton.layer.cornerRadius = 35
        fastButton.layer.borderWidth = 2
        fastButton.layer.borderColor = skyBlue.cgColor
        fastButton.tintColor = skyBlue
        fastButton.addImage(sfSymbol: "speaker.wave.3.fill", tintColor: skyBlue, size: 25)
        fastButton.addTarget(self, action: #selector(fastSpeakBtnTap), for: .touchUpInside)
        NSLayoutConstraint.activate([
            fastButton.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 12),
            fastButton.trailingAnchor.constraint(equalTo: smallView.trailingAnchor, constant: -95),
            fastButton.widthAnchor.constraint(equalToConstant: 70),
            fastButton.heightAnchor.constraint(equalToConstant: 70)
            
        ])
    }
    
    
    @objc func cancelBtnTap(){
        self.removeFromSuperview()
    }
    
    @objc func slowSpeakBtnTap(){
        CodeHelper.speakArabicWord(word: wordLabel.text!, speech: "slow")
    }
    
    @objc func fastSpeakBtnTap(){
        CodeHelper.speakArabicWord(word: wordLabel.text!, speech: "fast")
    }
    
}
