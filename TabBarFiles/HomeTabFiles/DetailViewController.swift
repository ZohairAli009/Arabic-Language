//
//  DetailViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 28/11/2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var wordsCollectionView: UICollectionView!
    @IBOutlet var selectedWordsCountLbl: UILabel!
    
    var savedCategories: [String] = []
    var selectedCategory = "★ Recommended"
    var cellWidth = 0
    let cellPadding = 20
    var xPoint = 0
    
    var allWordsData: [CategoryWords] = []
    var trainingDataList: [TrainingData] = []
    var recommendedWords: [RecommendedWordsDataModel] = []
    var arabicWords = [String]()
    var englishWords = [String]()
    var alreadyKnownWords: [String: String] = [:]
    var selectedWords: [String: String] = [:]
    var categoryCount_1: [String: Int] = [:]
    var categoryCount_2: [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        loadAllWordsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listRecommendedWords()
        showCategoryData(categoryName: selectedCategory)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let gestures = wordsCollectionView.gestureRecognizers {
            for gesture in gestures {
                wordsCollectionView.removeGestureRecognizer(gesture)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name("dismissedDetailVC"), object: nil)
    }
    
    
    private func configureViewController(){
        if let categories = UserDefaults.standard.stringArray(forKey: "selectedCategory"){
            savedCategories = categories
            savedCategories.insert("★ Recommended", at: 0)
        }
        let nib = UINib(nibName: "WordsCollectionViewCell", bundle: nil)
        wordsCollectionView.register(nib, forCellWithReuseIdentifier: "WordsCollViewCell")
        
        // Gestures
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        wordsCollectionView.addGestureRecognizer(leftSwipe)
        wordsCollectionView.addGestureRecognizer(rightSwipe)
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(wordsCellActionBtnTap), name:  NSNotification.Name("ActionBtnsTapped"), object: nil)
        
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("ActionBtnsTapped"), object: nil)
    }
    
    @objc func wordsCellActionBtnTap(_ notification: NSNotification){
        guard let object = notification.object as? [String] else { return }
        let arabicWord = object[0]
        let englishWord = object[1]
        let btnType = object[2]
        
        switch btnType{
        case "already":
            alreadyKnownWords[arabicWord] = englishWord
            storeCategoryCount(arabicWord: arabicWord, type: 1)
            let progressData = ProgressData(alreadyKnown: alreadyKnownWords, difficult: [:], progressByCategory: categoryCount_1)
            userDefaults.updateProgressData(data: progressData, 1)
            
        case "learn":
            selectedWords[arabicWord] = englishWord
            storeCategoryCount(arabicWord: arabicWord, type: 2)
            selectedWordsCountLbl.text = "Words selected \(selectedWords.count)/4"
            UserDefaults.standard.setValue(selectedWords, forKey: "selectedWords")
            
        default:
            print("Default case: \(#function)")
        }
        
        reloadWordsCollection()
        // full fill the trining dataStructure by word and its category
        let lists = getRandomWordsByCategory(arabicAns: arabicWord, englishAns: englishWord)
        let arabicList = Array(lists[0])
        let englishList = Array(lists[1])
        let newData = TrainingData(arabicWord: arabicWord, englishWord: englishWord, arabicRandomWords: arabicList, englishRandomWords: englishList)
        trainingDataList.append(newData)

        // if words count is 4 show traing viewController 
        if selectedWords.count == 4{
            saveProgressDataInUserdefault()
            let vc = storyboard?.instantiateViewController(withIdentifier: "trainingVC") as! TrainingViewController
            vc.modalPresentationStyle = .fullScreen
            vc.traingData = trainingDataList
            present(vc, animated: true)
        }
    }
    
    func saveProgressDataInUserdefault(){
        var countByCategory: [String: Int] = [:]
        if selectedWords.count > 3{
            alreadyKnownWords.merge(selectedWords){(_, new) in new}
            countByCategory = categoryCount_2
        }
        let progressData = ProgressData(alreadyKnown: alreadyKnownWords, difficult: [:], progressByCategory: countByCategory)
        userDefaults.updateProgressData(data: progressData, 2)
    }
    
    
    func storeCategoryCount(arabicWord: String, type: Int){
        var wordCategory = ""
        if selectedCategory == "★ Recommended"{
            let data = recommendedWords.filter {$0.wordInfo.arabic == arabicWord}
            if let category = data.first?.wordsCategory{wordCategory = category}
        }else{
            wordCategory = selectedCategory
        }
        let progressData = userDefaults.getProgressData()
        if progressData.alreadyKnown.keys.contains(arabicWord){}
        else{
            switch type{
            case 1:
                // when user tap alreadyKnow button
                if categoryCount_1.keys.contains(wordCategory){
                    categoryCount_1[wordCategory]! += 1
                }else{ categoryCount_1[wordCategory] = 1 }
                
            case 2:
                // when user tap learn button and words are 4
                if categoryCount_2.keys.contains(wordCategory){
                    categoryCount_2[wordCategory]! += 1
                }else{ categoryCount_2[wordCategory] = 1 }
                
            default:
                print("default")
            }
        }
    }
    
    func resetSelectedWordsAfterTraining(){
        selectedWords.removeAll()
        alreadyKnownWords.removeAll()
        trainingDataList.removeAll()
    }
    
    
    func getRandomWordsByCategory(arabicAns: String, englishAns: String) -> [Set<String>] {
        var arabicRandomWords = Set<String>()
        var englishRandomWords = Set<String>()
        let categoryData: [CategoryWords] = allWordsData.filter {$0.name == selectedCategory}
        let randomIndexes = generateRandomIndexes(
            count: 6,
            upperLimit: categoryData.isEmpty ? recommendedWords.count : categoryData[0].words.count
        )
        arabicRandomWords.insert(arabicAns)
        englishRandomWords.insert(englishAns)
        if categoryData.isEmpty {
            let keys = recommendedWords.map {$0.wordInfo.arabic}
            let values = recommendedWords.map {$0.wordInfo.english}
            for index in randomIndexes {
                arabicRandomWords.insert(keys[index])
                englishRandomWords.insert(values[index])
                if arabicRandomWords.count == 4 && englishRandomWords.count == 4{
                    break
                }
            }
        } else {
            let data = categoryData[0]
            for index in randomIndexes {
                arabicRandomWords.insert(data.words[index].arabic)
                englishRandomWords.insert(data.words[index].english)
                if arabicRandomWords.count == 4 && englishRandomWords.count == 4{
                    break
                }
            }
        }

        return [arabicRandomWords, englishRandomWords]
    }

    // Generates a set of unique random indexes
    func generateRandomIndexes(count: Int, upperLimit: Int) -> Set<Int> {
        var randomIndexes = Set<Int>()
        while randomIndexes.count < count {
            let randomInt = Int.random(in: 0..<upperLimit)
            randomIndexes.insert(randomInt)
        }
        return randomIndexes
    }
    
    func loadAllWordsData(){
        JsonDataDecoder.loadJSONData { [weak self] list in
            if let wordsList = list {
                self?.allWordsData = wordsList
            }
        }
    }
    
    func listRecommendedWords(){
        for data in allWordsData{
            let randIndex = Int.random(in: 0...data.words.count - 1)
            let dataIndex = data.words[randIndex]
            let newData = RecommendedWordsDataModel(wordInfo: dataIndex, wordsCategory: data.name)
            recommendedWords.append(newData)
        }
    }
    
    
    func showCategoryData(categoryName: String){
        if categoryName == "★ Recommended"{
            arabicWords = recommendedWords.map {$0.wordInfo.arabic}
            englishWords = recommendedWords.map {$0.wordInfo.english}
        }else{
            if let category = allWordsData.first(where: {$0.name == categoryName}){
                arabicWords = category.words.map {$0.arabic}
                englishWords = category.words.map {$0.english}
            }
        }
        xPoint = 0
        DispatchQueue.main.async {
            self.wordsCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
        reloadWordsCollection()
    }
    
    func wordsMoreInfoBtnTap(arabicWord: String){
        var wordInfo: Word!
        if selectedCategory == "★ Recommended"{
            if let info = recommendedWords.first(where: {$0.wordInfo.arabic == arabicWord}){
                wordInfo = info.wordInfo
            }
        }else{
            if let category = allWordsData.first(where: {$0.name == selectedCategory}){
                if let info = category.words.first(where: {$0.arabic == arabicWord}){
                    wordInfo = info
                }
            }
        }
        let infoVC = WordsMoreInfoViewController(nibName: "WordsMoreInfoViewController", bundle: nil)
        infoVC.wordInfo = wordInfo
        infoVC.sheetPresentationController?.prefersGrabberVisible = true 
        present(infoVC, animated: true)
    }
    
    func scrollToCategoryCell(index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            self.categoryCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        })
    }
    
    func reloadCategoryCollView(){
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
    }
    
    func reloadWordsCollection(){
        DispatchQueue.main.async {
            self.wordsCollectionView.reloadData()
        }
    }
    
    @objc func handleLeftSwipe(){
        let maxPoint = (arabicWords.count - 1) * 340
        if xPoint < maxPoint {
            xPoint += (cellWidth + cellPadding)
            let offSet = CGPoint(x: xPoint, y: 0)
            wordsCollectionView.setContentOffset(offSet, animated: true)
        }
    }
    
    
    @objc func handleRightSwipe(){
        if xPoint > 0{
            xPoint -= (cellWidth + cellPadding)
            let offSet = CGPoint(x: xPoint, y: 0)
            wordsCollectionView.setContentOffset(offSet, animated: true)
        }
    }
    
    
    @IBAction func navButtonsTapped(_ sender: UIButton) {
        if sender.tag == 1{
            dismiss(animated: true)
        }else{
            UserDefaults.standard.setValue(false, forKey: "IntroScreenPopupKey")
        }
    }
    
    
}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return savedCategories.count
        }
        else if collectionView == wordsCollectionView{
            return arabicWords.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorySelectionCell", for: indexPath)
            
            let textLabel = cell.viewWithTag(1) as? UILabel
            textLabel?.text = savedCategories[indexPath.item]
            cell.layer.cornerRadius = 17.5
            if savedCategories[indexPath.item] == selectedCategory{
                cell.backgroundColor = UIColor(named: "Color-2")
                textLabel?.textColor = UIColor(named: "Color-1")
            }else{
                cell.backgroundColor = UIColor(named: "Color-1")
                textLabel?.textColor = UIColor(named: "Color-2")
            }
            return cell
        }
        else if collectionView == wordsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordsCollViewCell", for: indexPath) as! WordsCollectionViewCell
            cell.setCellWidth(view: view)
            
            let arabicWord = arabicWords[indexPath.row]
            cell.arabicWordLabel.text = arabicWord
            cell.englishWordLabel.text = englishWords[indexPath.row]
            cell.phoneticWordLabel.text = CodeHelper.translateArabicWord(arabicWords[indexPath.row])
            if cellWidth == 0{ cellWidth = Int(cell.frame.width) }
            if alreadyKnownWords.keys.contains(arabicWord){
                cell.alreadyKnowBtn.isHidden = true
                cell.learnBtn.isHidden = true
                cell.setActionLabelText("already")
            }
            else if selectedWords.keys.contains(arabicWord){
                cell.alreadyKnowBtn.isHidden = true
                cell.learnBtn.isHidden = true
                cell.setActionLabelText("learn")
            }else{
                cell.alreadyKnowBtn.isHidden = false
                cell.learnBtn.isHidden = false
                cell.actionLabel.text = ""
            }
            cell.moreInfoBtnAction = { [weak self] in
                self?.wordsMoreInfoBtnTap(arabicWord: arabicWord)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            let cell = collectionView.cellForItem(at: indexPath)
            let label = cell?.viewWithTag(1) as? UILabel
            guard let text = label?.text else { return }
            selectedCategory = text
            reloadCategoryCollView()
            showCategoryData(categoryName: text)
        }
    }
   
}
