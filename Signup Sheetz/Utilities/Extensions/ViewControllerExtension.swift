//
//  PopUp.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
//

import Foundation


import UIKit

extension UIViewController {
    
    func showOKAlert(with title:String?,and message: String?, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: completion))
        DispatchQueue.main.async { self.present(alert, animated: true, completion: nil) }
    }
    
    func showYesOrNoAlert(with title: String?, message: String?, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        DispatchQueue.main.async { self.present(alert, animated: true, completion: nil) }
    }
    
    

}
