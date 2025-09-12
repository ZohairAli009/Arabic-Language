//
//  CategoryCell.swift
//  Arabic-Language
//
//  Created by Zohair on 27/11/2024.
//

import UIKit

class CategoryCell: UITableViewCell {

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
        categoryNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        categoryNameLabel.textColor = .label
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            categoryNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categoryNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            categoryNameLabel.widthAnchor.constraint(equalToConstant: 250),
            
            checkMarkBtn.topAnchor.constraint(equalTo: categoryNameLabel.topAnchor),
            checkMarkBtn.bottomAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor),
            checkMarkBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            checkMarkBtn.widthAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    
}
