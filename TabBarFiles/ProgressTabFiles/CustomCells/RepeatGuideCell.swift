//
//  RepeatGuideCell.swift
//  Arabic-Language
//
//  Created by Zohair on 17/12/2024.
//

import UIKit

class RepeatGuideCell: UICollectionViewCell {
    
    var startBtnAction: (() -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func startBtnTapped(_ sender: Any) {
        startBtnAction()
    }
    
}
