//
//  ProgressCollectionViewCell.swift
//  Arabic-Language
//
//  Created by Zohair on 24/11/2024.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var progressView: UIView!
    @IBOutlet var wordsCountLabel: UILabel!
    @IBOutlet var wordsTotalCount: UILabel!
    @IBOutlet var viewWidth: NSLayoutConstraint!
    
    var progressLayer = CALayer()
    var progress: CGFloat = 0 {
        didSet{
            updateLayer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    
    private func configure(){
        progressView.layer.addSublayer(progressLayer)
        progressLayer.frame.size.height = progressView.bounds.height
        progressLayer.cornerRadius = 4
        progressLayer.backgroundColor = UIColor.systemGreen.cgColor
        iconImageView.layer.cornerRadius = 20
        iconImageView.contentMode = .center
        progressView.layer.cornerRadius = 4
    }
    
    
    func updateLayer(){
        progressLayer.frame = CGRect(x: 0, y: 0, width: progress, height: progressView.frame.height)
    }
    
    
    func setupCellWidth(byWidthOf width: CGFloat){
        self.frame.size.width = width
        viewWidth.constant = width
    }

}
