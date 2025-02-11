//
//  ProfileViewController.swift
//  Signup Sheetz
//
//  Created by Braintech on 31/01/25.
//

import UIKit
import SideMenu

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
    }
    
    
    @IBAction func showMenuAction(_ sender: Any) {
        
        let menu = SideMenuNavigationController(rootViewController: MenuViewController())
        menu.leftSide = true
     //   menu.blurEffectStyle = .dark
        menu.settings.presentationStyle = .menuSlideIn
        menu.alwaysAnimate = true
        menu.view.backgroundColor = .green
        menu.view.dropShadow()
        present(menu, animated: true, completion: nil)
    }
}
