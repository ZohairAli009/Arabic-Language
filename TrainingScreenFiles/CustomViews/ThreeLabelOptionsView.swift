//
//  OptionsView.swift
//  Arabic-Language
//
//  Created by Zohair on 02/12/2024.
//

import UIKit

class ThreeLabelOptionsView: UIView {
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(phonetic: String, arabic: String, english: String){
        super.init(frame: .zero)
        self.label1.text = phonetic
        self.label2.text = arabic
        self.label3.text = english
        configure()
    }
    
    
    private func configure(){
        label1 = UILabel()
        label2 = UILabel()
        label3 = UILabel()

        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)
        self.backgroundColor = UIColor(named: "Color-5")

        label1.textColor = .secondaryLabel
        label3.textColor = .secondaryLabel
        label2.font = UIFont.systemFont(ofSize: 28, weight: .light)

        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        label3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            label2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label1.bottomAnchor.constraint(equalTo: label2.topAnchor),
            
            label3.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor)
        ])
    }
}
