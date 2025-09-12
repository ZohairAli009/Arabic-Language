//
//  ProgressCellDetailVC.swift
//  Arabic-Language
//
//  Created by Zohair on 24/01/2025.
//

import UIKit

class ProgressCellDetailVC: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var progressView: UIView!
    @IBOutlet var learnButton: UIButton!
    @IBOutlet var learnWordsLabel: UILabel!
    @IBOutlet var totalCountLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    var categoryName: String!
    var totalCount: String!
    var learnCount: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        updateProgressView()
    }
    
    
    private func setupViewController(){
        imageView.layer.cornerRadius = 15
        progressView.layer.cornerRadius = 10
        learnButton.layer.cornerRadius = 32.5
        
        // show data
        imageView.image = UIImage(named: categoryName)
        categoryNameLabel.text = categoryName
        totalCountLabel.text = totalCount.removingPunctuation()
        learnWordsLabel.text = learnCount
        textLabel.text = "You have mastered and you know \(learnCount!) words out of \(totalCount!.removingPunctuation()) on this topic"
    }
    
    
    func updateProgressView(){
        let width = Int(progressView.frame.width)
        let height = Int(progressView.frame.height)
        let cleanStr = totalCount.replacingOccurrences(of: "/ ", with: "")
        let total = Int(cleanStr)
        let count = Int(learnCount)
        let progressWidth = width / total! * count!
        // Adding CALayer to progressView
        let layer = CALayer()
        layer.cornerRadius = 10
        layer.backgroundColor = UIColor.systemGreen.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: progressWidth, height: height)
        progressView.layer.addSublayer(layer)
    }
    
    
    @IBAction func learnBtnTapped(_ sender: UIButton) {
        dismiss(animated: false)
        NotificationCenter.default.post(name: NSNotification.Name("presentNewWordsVC"), object: categoryName)
    }
    
    @IBAction func cancelBtnTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
