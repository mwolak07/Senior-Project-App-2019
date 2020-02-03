//
//  cameraTabViewController.swift
//  SeniorProjectApp
//
//  Created by Gaurav Karkhanis on 2/2/20.
//  Copyright © 2020 Gaurav Karkhanis. All rights reserved.
//

import UIKit

class cameraTabViewController: UIViewController {

    @IBOutlet weak var captureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getElements()
        // Do any additional setup after loading the view.
    }
    
    func getElements() {
        Utilities.styleFilledButton(captureButton)
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
