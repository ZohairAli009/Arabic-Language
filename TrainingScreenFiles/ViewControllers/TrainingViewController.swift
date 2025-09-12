//
//  TrainingViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 30/11/2024.
//

import UIKit

class TrainingViewController: UIViewController {
    
    @IBOutlet var trainingLabel: UILabel!
    @IBOutlet var progressView: UIView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var CollectionView: UICollectionView!
    
    var xAxis = 0
    var traingData: [TrainingData] = []
    var progressLayer = CALayer()
    var trainingCellsCount = 18
    var pronunciationKey: Bool?
    var cellwidth = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    
    private func configureViewController(){
        progressView.layer.addSublayer(progressLayer)
        progressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: progressView.frame.height)
        progressLayer.backgroundColor = UIColor.label.cgColor
        
        // Register cells
        let nib1 = UINib(nibName: "LevelOneCell", bundle: nil)
        CollectionView.register(nib1, forCellWithReuseIdentifier: "Levelonecell")
        
        let nib2 = UINib(nibName: "ReadWordsCell", bundle: nil)
        CollectionView.register(nib2, forCellWithReuseIdentifier: "Readwordcell")
        
        let nib3 = UINib(nibName: "LevelTwoCell", bundle: nil)
        CollectionView.register(nib3, forCellWithReuseIdentifier: "Leveltwocell")
        
        let nib4 = UINib(nibName: "LevelThreeCell", bundle: nil)
        CollectionView.register(nib4, forCellWithReuseIdentifier: "Levelthreecell")
        
        let nib5 = UINib(nibName: "LevelThreeCell", bundle: nil)
        CollectionView.register(nib5, forCellWithReuseIdentifier: "Levelthreecell1")
        
        let nib6 = UINib(nibName: "LevelFourCell", bundle: nil)
        CollectionView.register(nib6, forCellWithReuseIdentifier: "Levelfourcell")
        
        let nib7 = UINib(nibName: "CongratulationCell", bundle: nil)
        CollectionView.register(nib7, forCellWithReuseIdentifier: "Congratulationcell")
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(handleLeftSwipe), name: NSNotification.Name("optionBtnTap"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showClueView), name: NSNotification.Name("keyBtnTap"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissView), name: NSNotification.Name("endTraining"), object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("optionBtnTap"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("keyBtnTap"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("endTraining"), object: nil)
    }
    
    
    func handlePronunciationCells(){
        pronunciationKey = UserDefaults.standard.bool(forKey: "Pronunciation")
        guard let pronounceKey = pronunciationKey else { return }
        if !pronounceKey{
            let width = cellwidth + 26
            xAxis += width * 5
            let offSet = CGPoint(x: xAxis, y: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.CollectionView.setContentOffset(offSet, animated: false)
                self.progressView.isHidden = true
                self.trainingLabel.isHidden = true
            })
        }else{
            handleLeftSwipe()
        }
    }
    
    
    @objc func handleLeftSwipe(){
        xAxis += (cellwidth + 20)
        if xAxis > 5700{
            xAxis += 40
            progressView.isHidden = true
            trainingLabel.isHidden = true
        }
        let offSet = CGPoint(x: xAxis, y: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4, execute: {
            self.CollectionView.setContentOffset(offSet, animated: true)
            self.progressLayer.frame.size.width += 21.43
        })
    }

    
    @IBAction func nextBtnTapped(_ sender: UIButton){
        xAxis += 360
        let offSet = CGPoint(x: xAxis, y: 0)
        CollectionView.setContentOffset(offSet, animated: true)
        progressLayer.frame.size.width += 21.43
        sender.isHidden = true
    }
    
    
    @objc func showClueView(_ notification: NSNotification){
        let arabicWord = notification.object as? String
        let clueView = GiveClueUIView(frame: view.bounds)
        clueView.wordLabel.text = arabicWord
        clueView.phoneticLabel.text = CodeHelper.translateArabicWord(arabicWord!)
        view.addSubview(clueView)
    }
    
    @objc func dismissView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.presentingViewController?.presentingViewController?.dismiss(animated: false)
        })
    }
}


extension TrainingViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainingCellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Readwordcell", for: indexPath) as! ReadWordsCell
            return cell
            
        case 1...4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Levelonecell", for: indexPath) as! LevelOneCell
            
            cell.setCellWidth(view: view)
            if cellwidth == 0{ cellwidth = Int(cell.frame.width) }
            let data = traingData[indexPath.item - 1]
            cell.optionsStackView.isUserInteractionEnabled = true
            cell.translationLabel.text = CodeHelper.translateArabicWord(data.arabicWord)
            cell.questionWordLabel.text = data.arabicWord
            cell.optionsList = data.englishRandomWords
            cell.correctOption = data.englishWord
            
            return cell
            
        case 5...8:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Leveltwocell", for: indexPath) as! LevelTwoCell
            
            cell.setCellWidth(view: view)
            let data = traingData[indexPath.item - 5]
            cell.optionsStackView.isUserInteractionEnabled = true
            cell.optionsList = data.arabicRandomWords
            cell.correctOption = data.arabicWord
            cell.questionLabel.text = data.englishWord
            
            return cell
            
        case 9...11:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Levelthreecell", for: indexPath) as! LevelThreeCell
            
            cell.setCellWidth(view: view)
            let data = traingData[indexPath.item - 9]
            cell.lettersList = CodeHelper.splitWordIntoLetters(data.arabicWord)
            cell.correctWord = data.arabicWord
            cell.wordLabel.text = data.englishWord
            cell.swipeLeftAction = { [weak self] in
                self?.handleLeftSwipe()
            }
            
            return cell 
            
        case 11...12:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Levelthreecell1", for: indexPath) as! LevelThreeCell
            
            cell.setCellWidth(view: view)
            let data = traingData[indexPath.item - 9]
            cell.lettersList = CodeHelper.splitWordIntoLetters(data.arabicWord)
            cell.correctWord = data.arabicWord
            cell.wordLabel.text = data.englishWord
            cell.swipeLeftAction = { [weak self] in
                guard let self = self else { return }
                if indexPath.item == 12{
                    self.handlePronunciationCells()
                }else{
                    self.handleLeftSwipe()
                }
            }
            
            return cell
            
        case 13...16:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Levelfourcell", for: indexPath) as! LevelFourCell
            cell.setCellWidth(view: view)
            let data = traingData[indexPath.item - 13]
            if indexPath.item == 14{
                cell.setupSpeechRecognizer()
            }
            if indexPath.item > 13{
                let correctWordData = traingData[indexPath.item - 14]
                if let key = pronunciationKey {
                    if key { CodeHelper.speakArabicWord(word: correctWordData.arabicWord, speech: "fast")}}
                        
            }
            if indexPath.item == 16{
                cell.correctAnsLabel.text = ""
                cell.userDirectionsLbl.text = "Press and hold button to record"
                
            }
            cell.phoneticLabel.text = CodeHelper.translateArabicWord(data.arabicWord)
            cell.arabicWordLbl.text = data.arabicWord
            cell.englishWord = data.englishWord
            cell.handleSwipeAction = { [weak self] in
                self?.handleLeftSwipe()
            }
            cell.handleWrongAnsAction = { [weak self] in
                let ac = UIAlertController(title: "PAY ATTENTION!\nCorrect word \"\(data.arabicWord)\"", message: nil, preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "Skip", style: .destructive, handler: {_ in
                    self?.handleLeftSwipe()
                }))
                let tryAgain = UIAlertAction(title: "Try again", style: .default)
                tryAgain.setValue(UIColor.label, forKey: "titleTextColor")
                ac.addAction(tryAgain)
                self?.present(ac, animated: true)
            }
            
            return cell
            
        case 17:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Congratulationcell", for: indexPath) as! CongratulationCell
            cell.setCellWidth(view: view)
            return cell
            
        default:
            print("")
        }
        
        return UICollectionViewCell()
    }
    
    
}
