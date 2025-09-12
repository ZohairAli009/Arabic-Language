//
//  setupCategoriesVC.swift
//  Arabic-Language
//
//  Created by Zohair on 27/11/2024.
//

import UIKit

class setupCategoriesVC: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var categoryTableView: UITableView!

    var selectedCategories: [String] = []
    var titleText: String = ""
    var cancelBtnImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController(){
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
        categoryTableView.layer.cornerRadius = 13
        categoryTableView.backgroundColor = UIColor(named: "Color-1")
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.showsHorizontalScrollIndicator = false
        if let list = UserDefaults.standard.stringArray(forKey: "selectedCategory") {
            selectedCategories = list
        }
        titleLabel.text = titleText
        cancelButton.setImage(UIImage(systemName: cancelBtnImage), for: .normal)
        cancelButton.tintColor = .label
    }
    
    func handleCheckmarkBtn(cell: CategoryCell?){
        if let btn = cell?.checkMarkBtn {
            if let category = cell?.categoryNameLabel.text{
                if selectedCategories.contains(category){
                    btn.addImage(sfSymbol: "square", tintColor: .lightGray, size: 25)
                    selectedCategories.removeAll {$0 == category}
                }else{
                    let tintColor = CodeHelper.valuesToUIColor(values: [83, 173, 240])
                    btn.addImage(sfSymbol: "checkmark.square.fill", tintColor: tintColor, size: 25)
                    selectedCategories.append(category)
                }
            }
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        if !selectedCategories.isEmpty{
            UserDefaults.standard.setValue(selectedCategories, forKey: "selectedCategory")
        }
        dismiss(animated: true)
    }
    
}


extension setupCategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 23
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryCell
        
        let categoryList = CategoriesData.categoriesList
        cell?.categoryNameLabel.text = categoryList[indexPath.row]
        if selectedCategories.contains(categoryList[indexPath.row]){
            let tintColor = CodeHelper.valuesToUIColor(values: [83, 173, 240])
            cell?.checkMarkBtn.addImage(sfSymbol: "checkmark.square.fill", tintColor: tintColor, size: 25)
        }else{
            cell?.checkMarkBtn.addImage(sfSymbol: "square", tintColor: .lightGray, size: 25)
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CategoryCell
        handleCheckmarkBtn(cell: cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
