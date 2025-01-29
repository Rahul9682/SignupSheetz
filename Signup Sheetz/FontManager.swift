//
//  FontManager.swift
//  Signup Sheetz
//
//  Created by Braintech on 27/01/25.
//

import Foundation


import UIKit

struct FontManager {
    // MARK: - Font Names
    enum FontWeight: String {
        case light = "AirbnbCereal_W_Lt"
        case book = "AirbnbCereal_W_Bk"
        case medium = "AirbnbCereal_W_Md"
        case bold = "AirbnbCereal_W_XBd"
        case black = "AirbnbCereal_W_Blk"
    }
    
    // MARK: - Font Getter
    static func customFont(weight: FontWeight, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: size) else {
            fatalError("Font \(weight.rawValue) not found. Make sure it is added in the Info.plist!")
        }
        return font
    }
}
