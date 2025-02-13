//
//  BackgroundView.swift
//  AdvanceProject
//
//  Created by braintech on 08/11/21.
//

import UIKit

class BackgroundView: UIView {

    //MARK: - OUTLETS
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var errorDescLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    //MARK: - PROPERTIES
    var didClickRefreshButton: (() -> Void)?
    
    //MARK: - LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    //MARK: - HELPERS
    func configureUI() {
        refreshButton?.layer.cornerRadius = 4
        refreshButton?.layer.masksToBounds = true
    }
    
    func configureUI(with backgroundImageName: UIImage?, color: UIColor = .clear, message: String?, isButtonEnable: Bool = false) {
        containerView.backgroundColor = color
        backgroundImageView.image = backgroundImageName
        errorDescLabel.text = "No Data Found !!"
        refreshButton.setTitleColor(UIColor.white, for: .normal)
        refreshButton.backgroundColor = UIColor.blue
        refreshButton.setTitle("  Refresh  ", for: .normal)
        if isButtonEnable {
            refreshButton.isHidden = false
        } else {
            refreshButton.isHidden = true
        }
        if backgroundImageName == nil {
            backgroundImageView.isHidden = true
        } else {
            backgroundImageView.isHidden = false
        }
    }
    
    //MARK: - BUTTONS
    @IBAction func refreshButton(_ sender: UIButton) {
        didClickRefreshButton?()
    }
}
