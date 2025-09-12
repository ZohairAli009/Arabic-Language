//
//  AlphabetsViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 10/12/2024.
//

import UIKit

class AlphabetsViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mainViewHeight: NSLayoutConstraint!
    
    var lettersArray: [ArabicLetters] = []
    var countingArray: [ArabicCounting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        loadJsonData()
    }
    
    
    private func setupViewController(){
        scrollView.contentInset.left = -1
        mainViewHeight.constant = view.frame.height + 50
    }
    
    
    private func loadJsonData(){
        lettersArray = ArabicAlphabets.arabicLetters
        countingArray = ArabicAlphabets.countingData
        reloadCollectionView()
    }
    
    
    private func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}


extension AlphabetsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? lettersArray.count : countingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alphabetCell", for: indexPath)
        cell.layer.cornerRadius = 10
        let label_1 = cell.viewWithTag(1) as! UILabel
        let label_2 = cell.viewWithTag(2) as! UILabel
        let label_3 = cell.viewWithTag(3) as! UILabel
        if indexPath.section == 0{
            label_1.text = lettersArray[indexPath.item].letter
            label_2.text = lettersArray[indexPath.item].name
            label_3.isHidden = true
        }else{
            label_1.text = countingArray[indexPath.item].number
            label_2.text = countingArray[indexPath.item].transliteration
            label_3.isHidden = false
            label_3.text = "\(indexPath.item)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if indexPath.section == 0{
            let letter = lettersArray[indexPath.item].letter
            let translation = lettersArray[indexPath.item].name
            let variation = lettersArray[indexPath.item].forms
            let detailVC = letterDetailViewController(alphabet: letter, translation: translation, variations: variation)
            detailVC.modalPresentationStyle = .pageSheet
            if let sheetController = detailVC.sheetPresentationController {
                sheetController.detents = [.custom { context in
                    return context.maximumDetentValue * 0.6
                }]
            }
            present(detailVC, animated: true)
        }
        if indexPath.section == 1{
            let arabicNumber = countingArray[indexPath.item].number
            let numTranslation = countingArray[indexPath.item].transliteration
            let detailVC = letterDetailViewController(number: arabicNumber, translation: numTranslation)
            detailVC.modalPresentationStyle = .pageSheet
            if let sheetController = detailVC.sheetPresentationController {
                sheetController.detents = [.custom { context in
                    return context.maximumDetentValue * 0.4
                }]
            }
            present(detailVC, animated: true)
        }
    }
    
    
    // SectionHeader
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "alphabetHeader", for: indexPath)
            let titleLabel = header.viewWithTag(1) as? UILabel
            let labels = ["Common sequence", "Numbers"]
            titleLabel?.text = labels[indexPath.section]
            return header
        }
        fatalError("Unexpected element kind")
    }
    
    
    // Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 7
        let CVWidth = collectionView.frame.width
        let cellSize = CGSize(width: (CVWidth / 4) - padding, height: (CVWidth / 4) / 1.4)
        return cellSize
    }
    
    
    
}
