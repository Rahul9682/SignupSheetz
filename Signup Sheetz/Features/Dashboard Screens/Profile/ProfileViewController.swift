//
//  ProfileViewController.swift
//  Signup Sheetz
//
//  Created by Braintech on 31/01/25.
//

import UIKit
import SideMenu

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Profile"
        self.containerView.layer.cornerRadius = 32
        self.containerView.clipsToBounds = true
        configureUI()
    }
    
    func configureUI() {
        nameContainerView.layer.cornerRadius = 60
        nameContainerView.layer.masksToBounds = true
        nameLabel.font = FontManager.customFont(weight: .medium, size: 32)
        let userData = LocalStorage.getUserData()?.user
        configureUI(userData: userData)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ProfileDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileDetailTableViewCell")
        self.tableView.register(UINib(nibName: "LogoutTableViewCell", bundle: nil), forCellReuseIdentifier: "LogoutTableViewCell")
    }
    
    func configureUI(userData: LoginUserData?) {
        nameLabel.text = self.viewModel.getNameLetters(firstName: userData?.firstName ?? "", lastName:  userData?.lastName ?? "")
    }
    
    //    @IBAction func showMenuAction(_ sender: Any) {
    //        
    //        let menu = SideMenuNavigationController(rootViewController: MenuViewController())
    //        menu.leftSide = true
    //        menu.blurEffectStyle = .dark
    //        menu.settings.presentationStyle = .menuSlideIn
    //        menu.alwaysAnimate = true
    //        menu.view.backgroundColor = .green
    //        menu.view.dropShadow()
    //        present(menu, animated: true, completion: nil)
    //    }
}

//MARK: -  UITableViewDelegate,UITableViewDataSource
extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.viewModel.arrayOfProfileDetail.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell", for: indexPath) as! ProfileDetailTableViewCell
            cell.configureUI(with: self.viewModel.arrayOfProfileDetail[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
            cell.onLogout = {
                self.showYesOrNoAlert(with: "Log out", message: "Are you sure you want to log out?") { alert in
                    self.logout()
                }
            }
            return cell
        }
    }
}

//MARK: - VIEWMODEL INTERACTIONS
extension ProfileViewController {
    private func logout() {
        self.viewModel.logout { result in
            switch result {
            case .success(_):
                LocalStorage.deleteUserData()
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: false)
            case .failure(let error):
                self.showOKAlert(with: "Error", and: error.localizedDescription) { alert in
                    
                }
            }
        }
    }
}
