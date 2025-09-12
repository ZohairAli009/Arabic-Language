//
//  TabBarViewController.swift
//  Arabic-Language
//
//  Created by Zohair on 18/11/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(named: "Color-3")
        tabBar.backgroundColor = UIColor(named: "Color-1")
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "IntroScreenPopupKey") != true{
            showIntroScreen()
            UserDefaults.standard.setValue(1, forKey: "installDayCount")
        }
    }

    
    func showIntroScreen(){
        if let introScreenVC = storyboard?.instantiateViewController(withIdentifier: "IntroScreenVC") as? IntroScreenViewController {
            introScreenVC.modalPresentationStyle = .overFullScreen
            self.present(introScreenVC, animated: false)
        }
    }
    
    
    @objc func appDidEnterBackground() {
        let currentDate = CodeHelper.currentDate()
        UserDefaults.standard.setValue(currentDate, forKey: "SavedPreviousDate")
        print(#function)
    }
}
