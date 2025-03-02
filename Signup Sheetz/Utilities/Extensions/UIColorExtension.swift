//
//  UIColorextension.swift
//  Signup Sheetz
//
//  Created by Braintech on 03/02/25.
//

import Foundation
import UIKit

extension UIColor {
    static let customGray = "#F2F2F2"
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let length = hexSanitized.count
        let r, g, b, a: CGFloat

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(hexaString: String, alpha: CGFloat = 1) {
        let chars = Array(hexaString.dropFirst())
        self.init(
            red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
            green: .init(strtoul(String(chars[2...3]),nil,16))/255,
            blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
            alpha: alpha
        )
    }
    
    static func customGrayColor() -> UIColor {
        let customGray = UIColor.init(hexaString: customGray)
        return customGray
    }
}
