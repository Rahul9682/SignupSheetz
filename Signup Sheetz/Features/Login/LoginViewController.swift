//
//  ViewController.swift
//  Signup Sheetz
//
//  Created by Braintech on 22/01/25.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupGradientBackground()
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
               
               // Define gradient colors (from light color at the top to a darker shade)
               gradientLayer.colors = [
                   UIColor.white.cgColor,  // Light color at the top
                   UIColor.systemBlue.cgColor // A light yellowish color at the bottom
               ]
        
               
               // Set the gradient direction (top to bottom)
               gradientLayer.startPoint = CGPoint(x: 0, y: 0)  // Top
               gradientLayer.endPoint = CGPoint(x: 1, y: 1)    // Bottom
               
               // Set the gradient layer's frame to cover the entire screen
               gradientLayer.frame = view.bounds
               
               // Add the gradient layer to the view's layer
               view.layer.insertSublayer(gradientLayer, at: 0)
       }

}

