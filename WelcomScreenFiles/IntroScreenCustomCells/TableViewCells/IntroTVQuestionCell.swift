//
//  TVQuestionCell.swift
//  Arabic-Language
//
//  Created by Zohair on 21/11/2024.
//

import UIKit

class IntroTVQuestionCell: UITableViewCell {

    var checkMarkBtn = UIButton()
    var optionLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    private func configure(){
        addSubview(checkMarkBtn)
        addSubview(optionLabel)
        
        checkMarkBtn.translatesAutoresizingMaskIntoConstraints = false
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionLabel.font = UIFont.boldSystemFont(ofSize: 17)
        optionLabel.textColor = .white
        optionLabel.numberOfLines = 2
        optionLabel.textAlignment = .natural
        checkMarkBtn.addImage(sfSymbol: "square", tintColor: .lightGray, size: 25)
        
        NSLayoutConstraint.activate([
            optionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            optionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            optionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            optionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70),
            
            checkMarkBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15),
            checkMarkBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            checkMarkBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            checkMarkBtn.widthAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    

}
