//
//  ReadWordsCell.swift
//  Arabic-Language
//
//  Created by Zohair on 03/12/2024.
//

import UIKit

class ReadWordsCell: UICollectionViewCell {

    @IBOutlet var wordsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStackView()
        layer.cornerRadius = 15
    }
    
    
    private func setupStackView(){
        wordsStackView.spacing = 0.5
        wordsStackView.distribution = .fillEqually
        wordsStackView.layer.cornerRadius = 15
        wordsStackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        wordsStackView.layer.masksToBounds = true
        let wordsList = CodeHelper.getSelectedWordsLists()
        for i in 0...3{
            let view = ThreeLabelOptionsView(frame: CGRect(x: 0, y: 0, width: wordsStackView.frame.width, height: 100))
            view.label1.text = CodeHelper.translateArabicWord(wordsList[0][i])
            view.label2.text = wordsList[0][i]
            view.label3.text = wordsList[1][i]
            wordsStackView.addArrangedSubview(view)
        }
    }

}
