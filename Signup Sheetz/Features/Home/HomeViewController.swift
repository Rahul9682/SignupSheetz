//
//  HomeViewController.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlet's
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchbarView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var upComingLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - Properties
    let cellSpacing: CGFloat = 8
    let leadingTrailingPadding: CGFloat = 16
    let itemCount = 10
    
    //MARK: - Life-Cycle-Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    //MARK: - Helpers
    func setupView() {
        containerView.layer.cornerRadius = 30
        searchbarView.layer.cornerRadius = 10
        searchbarView.layer.borderWidth = 1
        searchbarView.layer.borderColor = UIColor.init(hex: "E4DFDF")?.cgColor
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        eventTableView.register(UINib(nibName: "MyEventTableViewCell", bundle: nil), forCellReuseIdentifier: "MyEventTableViewCell")
        
        if let layout = categoryCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.minimumInteritemSpacing = cellSpacing
                   layout.minimumLineSpacing = cellSpacing
               }
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search events...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "747688")]
        )
        configureNavigation()
    }
    
    
    private func configureNavigation() {
        let navigationBar = Bundle.main.loadNibNamed("CustomNavigationBar", owner: self, options: nil)?.first as? CustomNavigationBar
        navigationBar?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        navigationBar?.frame = self.navigationBar.bounds
        navigationBar?.configureUI(with: UIImage(named: "user"), topLabelText: "Welcome", bottomLabelText: LocalStorage.getUserData()?.firstName, trailingImage: UIImage(named: "bell"))
      //  navigationBar?.notificationButton.isHidden = false
      //  navigationBar?.backButton.isHidden = false
        navigationBar?.didClickSideMenuButton = {
            //self.findHamburguerViewController()?.showMenuViewController()
        }
        navigationBar?.didClickNotificationButton = {
//            if let _ = UserDefaults.standard.value(forKey: Auth.Keys.userId) as? Int {
//                let storyBoard = UIStoryboard(name: Storyboards.notificationStoryboard, bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else {
//                let storyBoard = UIStoryboard(name: Storyboards.loginStoryboard, bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                vc.successDelegate = self
//                vc.loginDismissalType = .homeToNotification
//                self.navigationController?.present(vc, animated: true)
//            }
        }
        self.navigationBar.addSubview(navigationBar!)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
//        if indexPath.row == 0 {
//            return UIEdgeInsets(top: 0, left: leadingTrailingPadding, bottom: 0, right: cellSpacing / 2)
//        } else if indexPath.row == itemCount - 1 {
//            return UIEdgeInsets(top: 0, left: cellSpacing / 2, bottom: 0, right: leadingTrailingPadding)
//        } else {
//            return UIEdgeInsets(top: 0, left: cellSpacing / 2, bottom: 0, right: cellSpacing / 2)
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150, height: 60)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: leadingTrailingPadding, bottom: 0, right: leadingTrailingPadding)
        }
}

//MARK: -  UITableViewDelegate,UITableViewDataSource
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEventTableViewCell", for: indexPath) as! MyEventTableViewCell
        
        return cell
    }
    
    
}
