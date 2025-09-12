//
//  WordsDetailViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 16/12/2024.
//

import UIKit

class WordsDetailViewController: UIViewController {

    @IBOutlet private var wordsCollectionView: UICollectionView!
    
    var xPoint = 0
    var wordsData: [String: String]!
    var wordsDataKeys: [String]!
    var repeatedWords: [String] = []
    var scrollToIndexPath: Int!
    private var cellWidth = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureViewController(){
        let nib1 = UINib(nibName: "AlreadyKnownWordCell", bundle: nil)
        wordsCollectionView.register(nib1,forCellWithReuseIdentifier: "AlreadKnownWordCell")
        let nib2 = UINib(nibName: "RepeatGuideCell", bundle: nil)
        wordsCollectionView.register(nib2,forCellWithReuseIdentifier: "RepeatGuideCell")
        
        wordsDataKeys = Array(wordsData.keys)
        wordsDataKeys.append("")
        repeatedWords.removeAll()
        wordsCollectionView.backgroundColor = .clear
    }
    
    
    private func handleLeftSwipe(){
        let maxPoint = (wordsDataKeys.count - 1) * cellWidth
        if scrollToIndexPath != nil{
            xPoint = scrollToIndexPath * (cellWidth + 10)
            let offSet = CGPoint(x: xPoint, y: 0)
            wordsCollectionView.setContentOffset(offSet, animated: false)
            scrollToIndexPath = nil
            return
        }
        if xPoint >= maxPoint{
            self.dismiss(animated: true)
        }
        xPoint += cellWidth + 10
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            let offSet = CGPoint(x: self.xPoint, y: 0)
            self.wordsCollectionView.setContentOffset(offSet, animated: true)
        })
    }
}


extension WordsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordsData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepeatGuideCell", for: indexPath) as! RepeatGuideCell
            cell.layer.cornerRadius = 15 
            cell.startBtnAction = { [weak self] in
                self?.handleLeftSwipe()
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlreadKnownWordCell", for: indexPath) as! AlreadyKnownWordCell
        
        let arabicWord = wordsDataKeys[indexPath.item - 1]
        cell.transLabel.text = CodeHelper.translateArabicWord(arabicWord)
        cell.arabicLabel.text = arabicWord
        cell.englishLabel.text = wordsData[arabicWord]
        if !repeatedWords.contains(arabicWord){
            cell.repeatedView.isHidden = true
            cell.repeatBtn.isHidden = false
        }
        cell.cancelBtnAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        cell.repeatBtnAction = { [weak self] in
            guard let self = self else { return }
            self.handleLeftSwipe()
            self.repeatedWords.append(arabicWord)
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        let width = screenWidth - 70
        cellWidth = Int(width)
        return CGSize(width: width, height: 420)
    }
    
    
}
