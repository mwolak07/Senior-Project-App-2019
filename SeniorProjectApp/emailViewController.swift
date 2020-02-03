//
//  emailViewController.swift
//  SeniorProjectApp
//
//  Created by Gaurav Karkhanis on 2/2/20.
//  Copyright © 2020 Gaurav Karkhanis. All rights reserved.
//

import UIKit

class emailViewController: UIViewController {

    @IBOutlet weak var emailButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func emailButtonPress(_ sender: Any) {
        //let mailURL = URL(string: "message://")!
            let appURL = URL(string: "mailto:info@receipthub.com")!
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
                print("one")
            }
            else {
                UIApplication.shared.openURL(appURL as URL)
                print("two")
            }
            print("three")
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
