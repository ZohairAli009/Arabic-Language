//
//  ProgressViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 12/12/2024.
//

import UIKit

class ProgressViewController: UIViewController{
    
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet var wordsTableView: UITableView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet var calendarView: UIView!
    @IBOutlet var mainViewHeight: NSLayoutConstraint!
    @IBOutlet var mainViewWidth: NSLayoutConstraint!
    @IBOutlet var completedDayLabel: UILabel!
    @IBOutlet var trainingDaysLabel: UILabel!
    
    var colorsList: [UIColor] = []
    var labelNames: [String] = []
    var monthsList: [String] = []
    var calendarData: [String: [String]] = [:]
    var completedDays: [String] = []
    var progressData: ProgressData!
    var progressDataCount = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProgressData()
    }
    
    private func setupViewController(){
        wordsTableView.layer.cornerRadius = 15
        scrollView.contentInset.left = -5
        colorsList = [.systemGreen, .systemRed]
        labelNames = ["Already know", "Difficult"]
        calendarCollectionView.backgroundColor = .clear
        trainingDaysLabel.layer.cornerRadius = 30
        trainingDaysLabel.layer.masksToBounds = true
        completedDayLabel.layer.cornerRadius = 30
        completedDayLabel.layer.masksToBounds = true
        readyCalenderData()
        mainViewWidth.constant = view.frame.width + 5
        
        // Fetch saved data from Userdefaults().
        if let days = UserDefaults().array(forKey: "CompletedDays") as? [String] {
            completedDays = days
        }
    }
    
    func getDateOfAllWeek(week: Int){
        let calender = Calendar.current
        if let date = calender.date(byAdding: .weekOfMonth, value: week, to: Date()){
            let datesList = CodeHelper.getDatesOfCurrentWeek(currentDate: date)
            if let month = datesList.keys.first, let dates = datesList.values.first{
                if calendarData.keys.contains(month){
                    calendarData[month]! += dates
                }else{
                    calendarData[month] = dates
                }
                if !monthsList.contains(month){ monthsList.append(month) }
            }
        }
        
    }

    
    func readyCalenderData(){
        for i in -2...0{
            getDateOfAllWeek(week: i)
        }
        if monthsList.count == 1{
            mainViewHeight.constant -= 40
        }
    }
    
    func loadProgressData(){
        progressData = userDefaults.getProgressData()
        let count_1 = progressData.alreadyKnown.count
        let count_2 = progressData.difficult.count
        progressDataCount = [count_1, count_2]
        DispatchQueue.main.async {
            self.wordsTableView.reloadData()
        }
    }
}

// MARK: - TableView Extension
extension ProgressViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordsDataTVCell", for: indexPath)
        cell.selectionStyle = .none
        let colorView = cell.viewWithTag(1)
        let nameLabel = cell.viewWithTag(2) as! UILabel
        let countLabel = cell.viewWithTag(3) as! UILabel
        
        colorView?.layer.cornerRadius = 11
        colorView?.backgroundColor = colorsList[indexPath.row]
        nameLabel.text = labelNames[indexPath.row]
        countLabel.text = String(progressDataCount[indexPath.row])
        
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ProgressWordsViewController()
        if indexPath.item == 0{
            guard progressData.alreadyKnown.count != 0 else { return }
            detailVC.progressData = progressData.alreadyKnown
            detailVC.titleText = "Already Know"
        }else{
            guard progressData.difficult.count != 0 else { return }
            detailVC.progressData = progressData.difficult
            detailVC.titleText = "Difficult Words"
        }
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

// MARK: - CollectionView Extension
extension ProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return monthsList.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let month = monthsList[section]
        return calendarData[month]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVDateCell", for: indexPath)

        if let dateLabel = cell.viewWithTag(1) as? UILabel {
            dateLabel.layer.cornerRadius = 20
            dateLabel.layer.masksToBounds = true

            let currentDate = CodeHelper.currentDateString()
            let monthKey = monthsList[indexPath.section]
            let dateLabelText = calendarData[monthKey]?[indexPath.item] ?? ""
            let green = CodeHelper.valuesToUIColor(values: [10, 199, 15])
            dateLabel.text = dateLabelText
            if dateLabelText == currentDate{
                dateLabel.backgroundColor = .clear
                dateLabel.layer.borderWidth = 2
                dateLabel.layer.borderColor = green.cgColor
            }
            if completedDays.contains(dateLabelText){
                if dateLabelText == currentDate{
                    dateLabel.layer.borderWidth = 2
                    dateLabel.layer.borderColor = UIColor.white.cgColor
                }
                dateLabel.backgroundColor = green
                dateLabel.textColor = .white
            }
        }

        cell.layer.cornerRadius = 20
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "calenderHeader", for: indexPath)
            if let label = header.viewWithTag(1) as? UILabel {
                label.text = monthsList[indexPath.section]
            }
            return header
        }
        fatalError("Unexpected element kind")
    }
}
