//
//  Protocols.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 29/01/25.
//

import Foundation

protocol DelegateTextField {
    func didChangeTextField(with text: String, and type: TextFieldType)
}
