//
//  ViewController.swift
//  SeniorProjectApp
//
//  Created by Gaurav Karkhanis on 11/26/19.
//  Copyright © 2019 Gaurav Karkhanis. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
            Utilities.styleFilledButton(signUpButton)
            Utilities.styleFilledButton(loginButton)
        }
    
}

