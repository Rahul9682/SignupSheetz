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
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var upComingLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var backgroundView: BackgroundView!
    
    //MARK: - Properties
    let cellSpacing: CGFloat = 8
    let leadingTrailingPadding: CGFloat = 16
    private var viewModel = HomeViewModel()
    var background: BackgroundView?
    
    //MARK: - Life-Cycle-Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCategories()
    }
    
    //MARK: - Helpers
    func setupView() {
        containerView.layer.cornerRadius = 32
        searchbarView.layer.cornerRadius = 10
        searchbarView.layer.borderWidth = 1
        searchbarView.layer.borderColor = UIColor.init(hex: "E4DFDF")?.cgColor
        
        upComingLabel.font = FontManager.customFont(weight: .medium, size: 16)
        categoriesLabel.font = FontManager.customFont(weight: .medium, size: 16)
        
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
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "747688") as Any]
        )
        configureNavigation()
    }
    
    
    private func configureNavigation() {
        let user = LocalStorage.getUserData()?.user
        let navigationBar = Bundle.main.loadNibNamed("CustomNavigationBar", owner: self, options: nil)?.first as? CustomNavigationBar
        navigationBar?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        navigationBar?.frame = self.navigationBar.bounds
        navigationBar?.configureUI(with: UIImage.userPlaceholder, topLabelText: "Welcome", bottomText: "\(user?.firstName ?? "") \(user?.lastName ?? "")", trailingImage: UIImage.bellIcon)
        navigationBar?.didClickSideMenuButton = {}
        navigationBar?.didClickNotificationButton = {}
        self.navigationBar.addSubview(navigationBar!)
    }
    
    //MARK: CONFIGURE BACKGROUND
    private func configureBackground(with image: UIImage?, message: String?, count: Int, isButtonEnable: Bool) {
        DispatchQueue.main.async { [self] in
            if count == 0 {
                if self.background == nil {
                    self.background = Bundle.main.loadNibNamed("BackgroundView", owner: self, options: nil)?.first as? BackgroundView
                    self.background?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                    self.background?.frame = self.backgroundView.bounds
                    self.background?.configureUI(with: image, message: message, isButtonEnable: isButtonEnable)
                }
                self.eventTableView.isHidden = true
                self.backgroundView.backgroundColor = UIColor.white
                self.backgroundView.addSubview(self.background!)
            } else {
                if self.background != nil {
                    self.background?.removeFromSuperview()
                }
                self.eventTableView.isHidden = false
                self.backgroundView.backgroundColor = UIColor.customGrayColor()
                self.eventTableView.reloadData()
            }
            self.background?.didClickRefreshButton = {
                self.getCategories()
            }
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.arrayOfCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        if let category = self.viewModel.arrayOfCategories?[indexPath.row] {
            cell.configureUI(with: category)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: leadingTrailingPadding, bottom: 0, right: leadingTrailingPadding)
    }
}

//MARK: -  UITableViewDelegate,UITableViewDataSource
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayOfEvents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        if let eventID = self.viewModel.arrayOfEvents?[indexPath.row].id {
            vc.eventID = "\(eventID)"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEventTableViewCell", for: indexPath) as! MyEventTableViewCell
        if let event = self.viewModel.arrayOfEvents?[indexPath.row] {
            cell.configureUI(with: event)
        }
        return cell
    }
}

//MARK: - VIEWMODEL INTERACTIONS
extension HomeViewController {    
    private func getCategories() {
        self.viewModel.getCategories { result in
            switch result {
            case .success(_):
                self.categoryCollectionView.reloadData()
                self.getEvents()
            case .failure(let error):
                self.getEvents()
            }
        }
    }
    
    private func getEvents() {
        self.viewModel.getEvents { result in
            switch result {
            case .success(let message):
                if let count = self.viewModel.arrayOfEvents?.count {
                    self.configureBackground(with: UIImage.noDataFound, message: message, count: count, isButtonEnable: true)
                }
            case .failure(let error):
                self.configureBackground(with: UIImage.noDataFound, message: error.localizedDescription, count: 0, isButtonEnable: true)
            }
        }
    }
}
