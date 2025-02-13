//
//  MyInvitationsViewController.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
//

import UIKit

class MyInvitationsViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundView: BackgroundView!
    
    var background: BackgroundView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Invitation"
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 32
        self.configureBackground(with: UIImage.noDataImage, message: "No Data Found", count: 0)
    }
    
    //MARK: CONFIGURE BACKGROUND
    private func configureBackground(with image: UIImage?, message: String?, count: Int) {
        DispatchQueue.main.async { [self] in
            if count == 0 {
                if self.background == nil {
                    self.background = Bundle.main.loadNibNamed("BackgroundView", owner: self, options: nil)?.first as? BackgroundView
                    self.background?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                    self.background?.frame = self.backgroundView.bounds
                    self.background?.configureUI(with: image, message: message)
                }
                // self.eventTableView.isHidden = true
                self.backgroundView.backgroundColor = UIColor.white
                self.backgroundView.addSubview(self.background!)
            } else {
                if self.background != nil {
                    self.background?.removeFromSuperview()
                }
                // self.eventTableView.isHidden = false
                self.backgroundView.backgroundColor = UIColor.customGrayColor()
                // self.eventTableView.reloadData()
            }
            self.background?.didClickRefreshButton = {
//                if isButtonEnable {
//                    self.getCategoryHomeData()
//                }
            }
        }
    }
}
