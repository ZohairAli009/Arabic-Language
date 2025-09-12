//
//  WordsInDayViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 19/12/2024.
//

import UIKit

class WordsInDayViewController: UIViewController {
    
    @IBOutlet var btn_1: UIButton!
    @IBOutlet var btn_2: UIButton!
    @IBOutlet var btn_3: UIButton!
    
    var selectedNumber: Int! {
        didSet{
            UserDefaults.standard.setValue(selectedNumber, forKey: "LearningWordsInADay")
        }
    }
    var buttonsList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsList = [btn_1, btn_2, btn_3]
        setupSetting()
    }
    
    
    private func setupSetting(){
        let imgName = "checkmark.circle.fill"
        let wordCount = UserDefaults.standard.integer(forKey: "LearningWordsInADay")
        switch wordCount{
        case 4:
            btn_1.addImage(sfSymbol: imgName, tintColor: .tintColor, size: 20)
        case 8:
            btn_2.addImage(sfSymbol: imgName, tintColor: .tintColor, size: 20)
        case 12:
            btn_3.addImage(sfSymbol: imgName, tintColor: .tintColor, size: 20)
        default:
            print("Defualt")
        }
    }
    
    func resetWordBtnStyle(sender: UIButton){
        for btn in buttonsList{
            if btn == sender{ continue }
            btn.addImage(sfSymbol: "circle",tintColor: .secondaryLabel ,size: 20)
        }
    }

    @IBAction func chooseWordBtnTapped(_ sender: UIButton) {
        switch sender.tag{
        case 1:
            selectedNumber = 4
        case 2:
            selectedNumber = 8
        case 3:
            selectedNumber = 12
        default:
            print("Defualt")
        }
        // Configuration
        sender.addImage(sfSymbol: "checkmark.circle.fill",tintColor: .tintColor,size: 20)
        resetWordBtnStyle(sender: sender)
    }
    
    
    @IBAction func backButtonTap(_ sender: UIButton) {
        dismiss(animated: false)
    }
}
