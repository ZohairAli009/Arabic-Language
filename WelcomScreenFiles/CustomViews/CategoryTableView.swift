//
//  CategoryTableView.swift
//  Arabic-Language
//
//  Created by Zohair on 19/11/2024.
//

// MARK: Reuseable tableView

import UIKit

class CategoryTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCategory: [String] = []
    var dataList: [String] = []
    var selectAllKey = false

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    private func setupTableView() {
        delegate = self
        dataSource = self
        register(IntroTVCategoryCell.self, forCellReuseIdentifier: "TVCategoryCell")
        backgroundColor = .clear
        dataList = CategoriesData.categoriesList
        dataList.insert("Select all", at: 0)
        for i in 1...8{selectedCategory.append(dataList[i])}
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(observerMethod), name: NSNotification.Name("NextBtnTap"), object: nil)
    }
    
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NextBtnTap"), object: nil)
    }
    
    func configure() {
        reloadData()
    }
    
    
    func checkmarkAllBoxes(){
        if selectAllKey{
            selectedCategory = dataList
        }else{
            selectedCategory.removeAll()
        }
    }
    
    func handleCheckmarkBtn(cell: IntroTVCategoryCell?){
        if let btn = cell?.checkMarkBtn {
            if let category = cell?.categoryNameLabel.text{
                if selectedCategory.contains(category){
                    btn.addImage(sfSymbol: "square", tintColor: .lightGray, size: 25)
                    selectedCategory.removeAll {$0 == category}
                }else{
                    btn.addImage(sfSymbol: "checkmark.square.fill", tintColor: .systemGreen, size: 25)
                    selectedCategory.append(category)
                }
            }
        }
    }
    
    
    @objc func observerMethod(){
        if !selectedCategory.isEmpty{
            selectedCategory.remove(at: 0)
        }
        UserDefaults.standard.setValue(selectedCategory, forKey: "selectedCategory")
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCategoryCell", for: indexPath) as? IntroTVCategoryCell
        tableView.separatorColor = .clear
        cell?.backgroundColor = .clear
        cell?.categoryNameLabel.text = dataList[indexPath.row]
        if selectedCategory.contains(dataList[indexPath.row]){
            cell?.checkMarkBtn.addImage(sfSymbol: "checkmark.square.fill", tintColor: .systemGreen, size: 25)
        }else{
            cell?.checkMarkBtn.addImage(sfSymbol: "square", tintColor: .lightGray, size: 25)
        }
        if selectAllKey {
            cell?.checkMarkBtn.addImage(sfSymbol: "checkmark.square.fill", tintColor: .systemGreen, size: 25)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? IntroTVCategoryCell
        handleCheckmarkBtn(cell: cell)
        if indexPath.row == 0{
            selectAllKey.toggle()
            checkmarkAllBoxes()
            tableView.reloadData()
        }
    }
}
