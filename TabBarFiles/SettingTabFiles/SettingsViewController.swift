//
//  SettingsViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 14/12/2024.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var wordInDayLabel: UILabel!
    @IBOutlet var pronunciationSwitch: UISwitch!
    @IBOutlet var answerSoundSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSettings()
    }
    
    
    func setupSettings(){
        let answerSound = UserDefaults.standard.bool(forKey: "AnswerSound")
        let pronunciation = UserDefaults.standard.bool(forKey: "Pronunciation")
        let wordsInADay = UserDefaults.standard.integer(forKey: "LearningWordsInADay")
        answerSoundSwitch.isOn = answerSound
        pronunciationSwitch.isOn = pronunciation
        wordInDayLabel.text = "\(wordsInADay)"
    }
    
    
    @IBAction func settingCellsTapped(_ sender: UIButton) {
        // Learning Topics setting
        if sender.tag == 1{
            let vc = setupCategoriesVC()
            vc.titleText = "Learning topics"
            vc.cancelBtnImage = "arrow.left"
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
        else{
            let wordVC = WordsInDayViewController()
            wordVC.modalPresentationStyle = .fullScreen
            wordVC.modalTransitionStyle = .crossDissolve
            present(wordVC, animated: true)
        }
    }
    
    
    @IBAction func settingSwitchTapped(_ sender: UISwitch) {
        if sender.tag == 3{
            if sender.isOn { UserDefaults.standard.setValue(true, forKey: "Pronunciation") }
            else{ UserDefaults.standard.setValue(false, forKey: "Pronunciation") }
        }
        else{
            if sender.isOn{ UserDefaults.standard.setValue(true, forKey: "AnswerSound") }
            else{ UserDefaults.standard.setValue(false, forKey: "AnswerSound") }
        }
    }
    
    
}

