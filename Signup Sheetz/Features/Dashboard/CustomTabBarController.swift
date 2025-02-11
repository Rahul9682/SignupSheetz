//
//  CustomTabBarController.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
import UIKit
import ESTabBarController


class CustomTabBarController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create view controllers
        //let firstVC = HomeViewController()
        
        let firstNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let secondVC = MyInvitationsViewController()
        let thirdVC = CreateEventViewController()
        let forthVC = MyEventViewController()
        let fifthNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        // Wrap them in navigation controllers
       // let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let centerButtonVC = UINavigationController(rootViewController: thirdVC)
        let forthNav = UINavigationController(rootViewController: forthVC)
       // let fifthNav = UINavigationController(rootViewController: fifthVC)
        
        firstNav.tabBarItem = ESTabBarItem(
            title: "Home",
            image: UIImage(named: "Home"),
            selectedImage: UIImage(named: "Home")
        )
        
        secondNav.tabBarItem = ESTabBarItem(
            title: "My Invitations",
            image: UIImage(named: "Work"),
            selectedImage: UIImage(named: "Work")
        )
        
        centerButtonVC.tabBarItem = ESTabBarItem(
            ExampleIrregularityContentView(),
            title: nil, // Hide title for center button
            image: UIImage(named: "eventAddition"),
            selectedImage: UIImage(named: "eventAddition")
        )
        
        
        
        forthNav.tabBarItem = ESTabBarItem(
            title: "My Events",
            image: UIImage(named: "Category"),
            selectedImage: UIImage(named: "Category")
        )
        
        fifthNav.tabBarItem = ESTabBarItem(
            title: "Profile",
            image: UIImage(named: "Profile"),
            selectedImage: UIImage(named: "Profile")
        )
        
        
        self.viewControllers = [firstNav, secondNav,centerButtonVC,forthNav,fifthNav]
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
    }
   
}
