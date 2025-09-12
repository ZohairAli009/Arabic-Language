//
//  ViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 18/11/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var newWordsView: UIView!
    @IBOutlet var cartoonImageView: UIImageView!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var progressCollectionView: UICollectionView!
    @IBOutlet var superViewHeight: NSLayoutConstraint!
    @IBOutlet var showMoreBtn: UIButton!
    @IBOutlet var newWordsTotalCount: UILabel!
    @IBOutlet var newWordsCountLabel: UILabel!
    @IBOutlet private var mainViewWidth: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var selectedCategories: [String] = []
    var showMoreBtnKey = false
    var previousCategoryListCount = 0
    var progressData: ProgressData!
    var countDictOfCategories: [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupNewWordsView()
        animateImageView()
        addContinuousAnimation(to: newWordsView)
        loadAllWordsData()
        displayCurrentDayFromInstall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    
    private func setupViewController(){
        let nib = UINib(nibName: "ProgressCollectionViewCell", bundle: nil)
        progressCollectionView.register(nib, forCellWithReuseIdentifier: "ProgressCVCell")
        mainScrollView.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        mainViewWidth.constant = view.frame.width + 5
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("IntroScreenDismiss"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("dismissedDetailVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(presentNewWordsView), name: NSNotification.Name("presentNewWordsVC"), object: nil)
        
    }
    
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("IntroScreenDismiss"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("dismissedDetailVC"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("presentNewWordsVC"), object: nil)
    }
    
    func setupNewWordsView(){
        let color1 = CodeHelper.valuesToUIColor(values: [255, 180, 1])
        let color2 = CodeHelper.valuesToUIColor(values: [255, 139, 1])
        CodeHelper.addGradientToView(newWordsView, colors: [color2, color1], radius: 23)
        newWordsView.isUserInteractionEnabled = true
        newWordsView.layer.cornerRadius = 23
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(newWordsViewTapped))
        newWordsView.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func newWordsViewTapped(_ gesture: UITapGestureRecognizer){
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        present(detailVC, animated: true)
    }
    
    
    @objc func presentNewWordsView(_ notification: NSNotification){
        let category = notification.object as! String
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.selectedCategory = category
        if let index = selectedCategories.firstIndex(of: category){
            detailVC.scrollToCategoryCell(index: index)
        }
        present(detailVC, animated: true)
    }
    
    @objc func reloadData(){
        if let categoryList = UserDefaults.standard.stringArray(forKey: "selectedCategory"){
            selectedCategories = categoryList
            let count = selectedCategories.count
            if count > 6{
                showMoreBtn.isHidden = false
                if showMoreBtnKey{
                    let newCount = count - previousCategoryListCount
                    superViewHeight.constant += CGFloat(newCount * 80)
                }else{
                    showMoreBtn.setTitle("Show \(count - 6) more topics ↓", for: .normal)
                }
            }else{
                showMoreBtn.isHidden = true
                let newCount = 6 - count
                let newHeight = 1080 - CGFloat(newCount * 80)
                superViewHeight.constant = newHeight
            }
        }
        // assigning progress data
        progressData = userDefaults.getProgressData()
        DispatchQueue.main.async {
            self.progressCollectionView.reloadData()
        }
        
        setupLearningWordsCount()
    }
    
    
    private func loadAllWordsData(){
        JsonDataDecoder.loadJSONData { [weak self] list in
            if let wordsList = list {
                for list in wordsList{
                    self?.countDictOfCategories[list.name] = list.words.count
                }
            }
        }
    }
    
    func setupLearningWordsCount(){
        // Total Count
        let wordsCount = UserDefaults.standard.integer(forKey: "LearningWordsInADay")
        newWordsTotalCount.text = "/ \(wordsCount)"
        // remembered count
        let count = UserDefaults.standard.integer(forKey: "RememberedWordsCount")
        newWordsCountLabel.text = "\(count)"
        // Set current day as complete traing day
        if wordsCount == count {
            let currrentdate = CodeHelper.currentDateString()
            if let savedCompletedDays = UserDefaults().array(forKey: "CompletedDays"){
                var updateList = savedCompletedDays
                updateList.append(currrentdate)
                
                UserDefaults().set(updateList, forKey: "CompletedDays")
            }else{
                UserDefaults().set([currrentdate], forKey: "CompletedDays")
            }
        }
    }
    
    
    func displayCurrentDayFromInstall(){
        guard let previosDate = UserDefaults.standard.object(forKey: "SavedPreviousDate")as? Date else { return }
        let current = CodeHelper.currentDate()
        if current > previosDate {
            let count = CodeHelper.getDifferenceBetweenDates(current: current, previous: previosDate)
            UserDefaults.standard.removeObject(forKey: "RememberedWordsCount")
            newWordsCountLabel.text = "0"
            dayLabel.text = "Day \(count)"
        }else{
            let previous = UserDefaults.standard.integer(forKey: "installDayCount")
            dayLabel.text = "Day \(previous)"
        }
    }
    
    func animateImageView(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: 390, y: 225)
        animation.toValue = CGPoint(x: 302, y: 218)
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        cartoonImageView.layer.add(animation, forKey: "slideIn")
    }
    
    
    func addContinuousAnimation(to view: UIView) {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       options: [.curveEaseIn, .allowUserInteraction],
                       animations: {
            view.transform = CGAffineTransform(scaleX: 1.04, y: 1.04)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.curveEaseOut, .allowUserInteraction],
                           animations: {
                view.transform = .identity
            }, completion: { _ in
                self.addContinuousAnimation(to: view)
            })
        })
    }
    
    @IBAction func showMoreBtnTap(_ sender: UIButton) {
        showMoreBtnKey.toggle()
        if showMoreBtnKey{
            var itemCount = selectedCategories.count
            previousCategoryListCount = itemCount
            if itemCount > 6{
                itemCount = itemCount - 6
                let newHeight = CGFloat(itemCount * 80) + superViewHeight.constant
                superViewHeight.constant = newHeight
                sender.setTitle("Show less ↑", for: .normal)
            }
        }else{
            var itemCount = selectedCategories.count
            itemCount -= 6
            let newHeight = superViewHeight.constant - CGFloat(itemCount * 80)
            superViewHeight.constant = newHeight
            sender.setTitle("Show \(itemCount) more topics ↓", for: .normal)
        }
    }
    
    
    @IBAction func setupBtnTapped(_ sender: UIButton) {
        let vc = setupCategoriesVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCVCell", for: indexPath) as! ProgressCollectionViewCell
        
        let CVWidth = collectionView.frame.width
        cell.setupCellWidth(byWidthOf: CVWidth)
        let category = selectedCategories[indexPath.item]
        cell.progress = 0
        cell.wordsCountLabel.text = "0"
        cell.categoryNameLabel.text = category
        cell.iconImageView.image = UIImage(named: "\(category)")
        if let totalCount = countDictOfCategories[category]{
            cell.wordsTotalCount.text = "/ \(totalCount)"
            if let actualCount = progressData.progressByCategory[category]{
                if actualCount < totalCount{
                    cell.progress = CGFloat((271 / totalCount) * actualCount)
                    cell.wordsCountLabel.text = "\(actualCount)"
                }else{
                    cell.progress = CGFloat(271)
                    cell.wordsCountLabel.text = "\(totalCount)"
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ProgressCollectionViewCell
        let detailVC = ProgressCellDetailVC()
        if  let name = cell.categoryNameLabel.text,
            let tCount = cell.wordsTotalCount.text,
            let count = cell.wordsCountLabel.text 
        {
            detailVC.categoryName = name
            detailVC.totalCount = tCount
            detailVC.learnCount = count
        }
        detailVC.modalPresentationStyle = .overFullScreen
        present(detailVC, animated: true)
    }
}

