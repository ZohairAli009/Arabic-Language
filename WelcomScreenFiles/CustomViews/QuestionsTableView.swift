//
//  QuestionsTableView.swift
//  Arabic-Language
//
//  Created by Zohair on 21/11/2024.
//

import UIKit

class QuestionsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var numberOfRows: Int = 0
    var indexcount: Int = 0
    var sectionCells: [IntroTVQuestionCell] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    
    private func setupTableView(){
        delegate = self
        dataSource = self
        register(IntroTVQuestionCell.self, forCellReuseIdentifier: "TVQuestioncell")
        backgroundColor = .clear
    }
    
    
    private func optionSelected(_ indexPath: IndexPath){
        let cell = self.cellForRow(at: indexPath) as? IntroTVQuestionCell
        if let button = cell?.checkMarkBtn {
            button.addImage(sfSymbol: "checkmark.square.fill", tintColor: .systemGreen, size: 25)
        }
        cell?.optionLabel.textColor = .black
        cell?.backgroundColor = .white
    }
    
    
    func resetCellColors(cell: IntroTVQuestionCell?){
        if let button = cell?.checkMarkBtn {
            button.addImage(sfSymbol: "square", tintColor: .lightGray, size: 25)
        }
        cell?.optionLabel.textColor = .white
        cell?.backgroundColor =  CodeHelper.valuesToUIColor(values: [51, 51, 51])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVQuestioncell", for: indexPath) as? IntroTVQuestionCell
        
        tableView.separatorColor = .none
        cell?.layer.cornerRadius = 13
        cell?.layer.borderWidth = 0.5
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.backgroundColor = CodeHelper.valuesToUIColor(values: [51, 51, 51])
        cell?.optionLabel.text = WelcomData.optionsList[indexcount][indexPath.row]
        sectionCells.append(cell!)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for cell in sectionCells{
            resetCellColors(cell: cell)
        }
        optionSelected(indexPath)
        NotificationCenter.default.post(name: NSNotification.Name("OptionSelected"), object: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
