//
//  TVCategoryCell.swift
//  Arabic-Language
//
//  Created by Zohair on 19/11/2024.
//

import UIKit

class IntroTVCategoryCell: UITableViewCell {
    
    var checkMarkBtn = UIButton()
    var categoryNameLabel = UILabel()
    
    
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
        addSubview(categoryNameLabel)
        
        checkMarkBtn.translatesAutoresizingMaskIntoConstraints = false
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        checkMarkBtn.addImage(sfSymbol: "square", tintColor: .lightGray, size: 25)
        categoryNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        categoryNameLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            checkMarkBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            checkMarkBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            checkMarkBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            checkMarkBtn.widthAnchor.constraint(equalToConstant: 30),
            
            categoryNameLabel.topAnchor.constraint(equalTo: checkMarkBtn.topAnchor),
            categoryNameLabel.bottomAnchor.constraint(equalTo: checkMarkBtn.bottomAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: checkMarkBtn.trailingAnchor, constant: 20),
            categoryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    
}
