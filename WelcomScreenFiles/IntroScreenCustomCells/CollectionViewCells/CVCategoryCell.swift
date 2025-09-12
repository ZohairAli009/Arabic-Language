//
//  CVCategoryCell.swift
//  Arabic-Language
//
//  Created by Zohair on 19/11/2024.
//

import UIKit

class CVCategoryCell: UICollectionViewCell {
    
    @IBOutlet var tableView: CategoryTableView!
    
    @IBOutlet var viewWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.configure()
    }

}
