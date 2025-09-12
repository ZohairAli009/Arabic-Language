//
//  LevelThreeCell.swift
//  Arabic-Language
//
//  Created by Zohair on 05/12/2024.
//

import UIKit

class LevelThreeCell: UICollectionViewCell {

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var questionView: UIView!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var lettersCollectionView: UICollectionView!
    @IBOutlet private var mainViewWidth: NSLayoutConstraint!
    
    var lettersList: [String] = []
    var buildString = ""
    var tappedIndexs: [IndexPath] = []
    var correctWord: String!
    var swipeLeftAction: (() -> Void)?
    var answerSoundKey: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        Configure()
    }
    
    
    private func Configure(){
        self.layer.cornerRadius = 15
        questionView.layer.cornerRadius = 15
        questionView.layer.masksToBounds = true
        questionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        answerLabel.text = ""
        answerLabel.textColor = .white
        answerSoundKey = UserDefaults.standard.bool(forKey: "AnswerSound")
    }
    
    
    @IBAction func hintBtnTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("keyBtnTap"), object: correctWord)
    }
    
    private func playSound(ofType: String){
        guard answerSoundKey else { return }
        if answerSoundKey{
            guard let soundURL = Bundle.main.url(forResource: ofType, withExtension: "mp3") else { return }
            CodeHelper.playSound(soundUrl: soundURL)
        }else{ return }
    }
    
    func setCellWidth(view: UIView){
        let screenWidth = view.frame.width
        let width = screenWidth - 73
        self.frame.size.width = width
        mainViewWidth.constant = width
    }
    
}


extension LevelThreeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func setupCollectionView(){
        lettersCollectionView.delegate = self
        lettersCollectionView.dataSource = self
        lettersCollectionView.register(LettersCVCell.self, forCellWithReuseIdentifier: "letterCell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lettersList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as! LettersCVCell
        
        if indexPath.item == 0{
            cell.addImageviewToCell()
            cell.letterLabel.isHidden = true
        }else{
            cell.letterLabel.isHidden = false
        }
        if indexPath.item > 0{
            cell.letterLabel.text = lettersList[indexPath.item - 1]
        }else{
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LettersCVCell
        if indexPath.item == 0{
            if !buildString.isEmpty{
                let removedChar = buildString.removeLast()
                let previousCell = collectionView.cellForItem(at: tappedIndexs.last!) as! LettersCVCell
                answerLabel.text = buildString
                previousCell.letterLabel.text = "\(removedChar)"
                tappedIndexs.removeLast()
            }
        }else{
            if let character = cell.letterLabel.text{
                buildString += character
                answerLabel.text = buildString
                cell.letterLabel.text = ""
                tappedIndexs.append(indexPath)
            }
            if buildString == correctWord{
                answerLabel.textColor = .green
                playSound(ofType: "CorrectAns")
                CodeHelper.speakArabicWord(word: correctWord, speech: "fast")
                swipeLeftAction!()
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 51, height: 55)
    }
    
    
    
}
