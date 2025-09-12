//
//  LettersCVCell.swift
//  Arabic-Language
//
//  Created by Zohair on 05/12/2024.
//

import UIKit

class LettersCVCell: UICollectionViewCell {
    
    let letterLabel = UILabel()
    let delImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        
        addSubview(letterLabel)
        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        letterLabel.textAlignment = .center
        letterLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        NSLayoutConstraint.activate([
            letterLabel.topAnchor.constraint(equalTo: self.topAnchor),
            letterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            letterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            letterLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        backgroundColor = UIColor(named: "Color-5")
        layer.cornerRadius = 12
    }
    
    
    func addImageviewToCell(){
        addSubview(delImageView)
        
        delImageView.translatesAutoresizingMaskIntoConstraints = false
        delImageView.layer.cornerRadius = 12
        delImageView.contentMode = .scaleAspectFit
        delImageView.image = UIImage(systemName: "delete.forward.fill")?.withRenderingMode(.alwaysOriginal)
        
        NSLayoutConstraint.activate([
            delImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            delImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            delImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            delImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
    }
}
