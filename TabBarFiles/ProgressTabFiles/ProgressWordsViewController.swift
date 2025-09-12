//
//  ProgressWordsViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 16/12/2024.
//

import UIKit

class ProgressWordsViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var progressData: [String: String]!
    var progressDataKeys: [String]!
    var titleText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "WordsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WordsTVCell")
        tableView.bounces = true
        progressDataKeys = Array(progressData.keys)
        titleLabel.text = titleText
    }

    
    @IBAction func repeatBtnTapped(_ sender: Any) {
        let vc = WordsDetailViewController()
        vc.wordsData = progressData
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        present(vc, animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: false)
    }
}


extension ProgressWordsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordsTVCell", for: indexPath) as! WordsTableViewCell
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        let key = progressDataKeys[indexPath.row]
        cell.arabicLabel.text = key
        cell.englishLabel.text = progressData[key]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WordsDetailViewController()
        vc.wordsData = progressData
        vc.scrollToIndexPath = indexPath.row + 1
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        present(vc, animated: true)
    }
    
    
}
