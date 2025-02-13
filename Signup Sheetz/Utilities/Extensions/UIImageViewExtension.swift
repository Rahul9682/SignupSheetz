//
//  ImageViewExtension.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import UIKit
import SDWebImage

extension UIImageView {
    func networkImage(with image: String?) {
        if let image = image {
            guard let imageUrl = URL(string: image) else { return }
            self.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolder"), options: .highPriority, context: nil)
        } else {
            self.image = #imageLiteral(resourceName: "placeHolder")
        }
    }
    
    func networkImageWithoutPlaceholder(with image: String?) {
        if let image = image {
            guard let imageUrl = URL(string: image) else { return }
            self.sd_setImage(with: imageUrl, placeholderImage: nil, options: .highPriority, context: nil)
        } else {
            self.image = #imageLiteral(resourceName: "placeHolder")
        }
    }
}
