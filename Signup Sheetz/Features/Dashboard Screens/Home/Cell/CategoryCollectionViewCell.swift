//
//  CategoryCollectionViewCell.swift
//  Signup Sheetz
//
//  Created by Braintech on 03/02/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlet's
    @IBOutlet weak var cateImage: UIImageView!
    @IBOutlet weak var cateName: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        confiqureUI()
    }
    
    func confiqureUI() {
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.layer.borderColor = UIColor.init(hex: "E4DFDF")?.cgColor
        containerView.layer.borderWidth = 1
        imageContainerView.layer.borderColor = UIColor.init(hex: "E4DFDF")?.cgColor
        imageContainerView.layer.borderWidth = 1
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.clipsToBounds = true
        cateName.font = FontManager.customFont(weight: .book, size: 14)
        cateName.textColor = UIColor.init(hex: "747688")
    }
    
    func configureUI(with data: CategoryData) {
        cateName.text = data.name ?? ""
        cateImage.networkImageWithoutPlaceholder(with: data.imageURL)
    }
}


