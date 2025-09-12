//
//  letterVariationView.swift
//  Arabic-Language
//
//  Created by Zohair on 11/12/2024.
//

import UIKit

class letterVariationView: UIView {
    let label_1 = UILabel()
    let label_2 = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubview(label_1)
        addSubview(label_2)
        
        label_1.translatesAutoresizingMaskIntoConstraints = false
        label_2.translatesAutoresizingMaskIntoConstraints = false
        label_1.font = UIFont.boldSystemFont(ofSize: 25)
        label_1.textAlignment = .center
        label_2.font = UIFont.systemFont(ofSize: 14)
        label_2.textAlignment = .center
        label_2.textColor = .secondaryLabel
        
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            label_1.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label_1.leadingAnchor.constraint(equalTo: leadingAnchor),
            label_1.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            label_2.topAnchor.constraint(equalTo: label_1.bottomAnchor, constant: 8),
            label_2.leadingAnchor.constraint(equalTo: leadingAnchor),
            label_2.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
