//
//  CongratulationCell.swift
//  Arabic-Language
//
//  Created by Zohair on 09/12/2024.
//

import UIKit

class CongratulationCell: UICollectionViewCell {
    @IBOutlet var mainViewwidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func continueBtnTap(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("endTraining"), object: nil)
        updateRemeberedWordsCount()
    }
    
    
    func updateRemeberedWordsCount(){
        let previous = UserDefaults.standard.integer(forKey: "RememberedWordsCount")
        let newCount = previous + 4
        UserDefaults.standard.setValue(newCount, forKey: "RememberedWordsCount")
    }
    
    func setCellWidth(view: UIView){
        let screenWidth = view.frame.width
        self.frame.size.width = screenWidth
        mainViewwidth.constant = screenWidth
    }
    
}
