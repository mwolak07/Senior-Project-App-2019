//
//  getStartedViewController.swift
//  SeniorProjectApp
//
//  Created by Gaurav Karkhanis on 2/2/20.
//  Copyright © 2020 Gaurav Karkhanis. All rights reserved.
//

import UIKit

class getStartedViewController: UIViewController {

    @IBOutlet weak var dashboardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements() {
    // Hide the error label
    Utilities.styleFilledButton(dashboardButton)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
