//
//  IntroScreenViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 19/11/2024.
//

import UIKit

class IntroScreenViewController: UIViewController {
    
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var laterBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var progressView = UIView()
    var progressLayer = CALayer()
    var progress: CGFloat = 0
    var screenCount: CGFloat = 0
    var xPoint: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupProgressView()
        progress = 50
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if progressLayer.superlayer == nil{
            progressView.layer.addSublayer(progressLayer)
        }
        progressLayer.frame = CGRect(x: 0, y: 0, width: progress, height: progressView.frame.height)
        progressLayer.backgroundColor = UIColor.systemGreen.cgColor
    }
    
    
    private func setupViewController(){
        let nib1 = UINib(nibName: "CVWelcomCell", bundle: nil)
        collectionView.register(nib1, forCellWithReuseIdentifier: "CVWelcomcell")
        
        let nib2 = UINib(nibName: "CVCategoryCell", bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: "CVCategorycell")
        
        let nib3 = UINib(nibName: "CVReminderCell", bundle: nil)
        collectionView.register(nib3, forCellWithReuseIdentifier: "CVRemindercell")
        
        let nib4 = UINib(nibName: "CVQuestionsCell", bundle: nil)
        collectionView.register(nib4, forCellWithReuseIdentifier: "CVQuestionscell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(enableNextBtn), name: NSNotification.Name("OptionSelected"), object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("OptionSelected"), object: nil)
    }
    
    @objc func enableNextBtn(){
        nextBtn.alpha = 1
        nextBtn.isEnabled = true
    }

    
    func setupProgressView(){
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.layer.cornerRadius = 2
        progressView.backgroundColor = .secondaryLabel
        progressView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 200),
            progressView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    
    func scrollToNextCell(){
        let width = view.frame.width
        xPoint += width + 10
        let offSet = CGPoint(x: xPoint, y: 0)
        collectionView.setContentOffset(offSet, animated: true)
    }
    
    
    func scrollToPreviousCell(){
        let width = view.frame.width
        xPoint -= width + 10
        let offSet = CGPoint(x: xPoint, y: 0)
        collectionView.setContentOffset(offSet, animated: true)
    }
    
    
    func handleProgressView(){
        switch screenCount {
        case 0...3:
            progress += 50
        case 4.0:
            progressView.isHidden = true
        case 7.0:
            progressView.isHidden = false
            progress = 28.57
        case 7...13:
            progress += 28.57
            
        default:
            print("Defualt case \(#function)")
        }
    }
    
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        screenCount += 1.0
        if screenCount < 15.0{
            scrollToNextCell()
            handleProgressView()
        }
        switch screenCount {
        case 1.0:
            previousBtn.isHidden = false
        case 5.0:
            NotificationCenter.default.post(name: NSNotification.Name("NextBtnTap"), object: nil)
        case 6.0:
            previousBtn.isHidden = true
            laterBtn.isHidden = false
            // introVC should only appears when install
            UserDefaults.standard.setValue(true, forKey: "IntroScreenPopupKey")
        case 7.0:
            nextBtn.isEnabled = false
            nextBtn.alpha = 0.7
            laterBtn.setTitle("", for: .normal)
            laterBtn.addImage(sfSymbol: "multiply", tintColor: .label, size: 20)
        case 8...13:
            nextBtn.isEnabled = false
            nextBtn.alpha = 0.7
        case 14.0:
            progressView.isHidden = true
            laterBtn.isHidden = true
            nextBtn.setTitle("Start Studing", for: .normal)
        case 15.0:
            dismiss(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name("IntroScreenDismiss"), object: nil)
        default:
            print()
        }
    }
    
    
    @IBAction func previousBtnTapped(_ sender: Any) {
        screenCount -= 1.0
        scrollToPreviousCell()
        progress -= 50
        switch screenCount {
        case 0.0:
            previousBtn.isHidden = true
            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 3.0:
            progressView.isHidden = false
            progress = 200
            
        default:
            print("Default case \(#function)")
        }
    }
    
    
    @IBAction func laterBtnTap(_ sender: Any) {
        let ac = UIAlertController(title: "Skip", message: "Are you sure you want to skip this survey.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        cancelAction.setValue(UIColor.white, forKey: "titleTextColor")
        ac.addAction(cancelAction)
        ac.addAction(UIAlertAction(title: "Skip", style: .destructive, handler: {_ in
            self.dismiss(animated: true)
        }))
        if let backView = ac.view.subviews.first?.subviews.first?.subviews.first {
            backView.layer.borderWidth = 1.5
            backView.layer.borderColor = UIColor.white.cgColor
        }
        present(ac, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("IntroScreenDismiss"), object: nil)
    }
    
}

// MARK: Extension

extension IntroScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let width = view.frame.width
        switch indexPath.item {
        case 0...3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVWelcomcell", for: indexPath) as! CVWelcomCell
            cell.frame.size.width = width
            cell.mainViewWidth.constant = width
            cell.label.text = WelcomData.welcomDataStrings[indexPath.item]
            cell.imageView.image = UIImage(named: "design-\(indexPath.item + 2)")
            return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCategorycell", for: indexPath) as! CVCategoryCell
            cell.frame.size.width = width
            cell.viewWidth.constant = width
            return cell
            
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVRemindercell", for: indexPath) as! CVReminderCell
            cell.frame.size.width = width
            cell.viewWidth.constant = width
            return cell
            
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVWelcomcell", for: indexPath) as! CVWelcomCell
            cell.frame.size.width = width
            cell.mainViewWidth.constant = width
            cell.label.text = "This will help to improve the quality of your learning"
            cell.imageView.image = UIImage(named: "design-6")
            return cell
            
        case 7...13:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVQuestionscell", for: indexPath) as! CVQuestionsCell
            cell.frame.size.width = width
            cell.viewWidth.constant = width
            cell.questionLabel.text = WelcomData.questionsList[indexPath.row - 7]
            cell.tableView.numberOfRows = WelcomData.optionsList[indexPath.row - 7].count
            cell.tableView.indexcount = indexPath.row - 7
            for i in cell.tableView.sectionCells{
                cell.tableView.resetCellColors(cell: i)
            }
            cell.tableView.sectionCells.removeAll()
            cell.tableView.reloadData()
            return cell
            
        case 14:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVWelcomcell", for: indexPath) as! CVWelcomCell
            cell.label.text = "We will take your answers in developing your learning program"
            cell.imageView.image = UIImage(named: "design-8")
            return cell
            
        default:
            fatalError("Unexpected indexPath.item: \(indexPath.item)")
        }
    }
}
