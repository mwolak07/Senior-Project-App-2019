//
//  mLViewController.swift
//  SeniorProjectApp
//
//  Created by Gaurav Karkhanis on 1/13/20.
//  Copyright © 2020 Gaurav Karkhanis. All rights reserved.
//

import UIKit
import Firebase

class mLViewController: UIViewController {

    @IBOutlet weak var ImageViewExample: UIImageView!
    
    @IBOutlet weak var textExtract: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textExtract)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ButtonTapped(_ sender: Any) {
        // Obtain image from camera
        let capturedImage: UIImage = ImageViewExample.image!
        
        // Initializing the text recognizer
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        
        // Making the image MLKit readable
        let image = VisionImage(image: capturedImage)
        
        // Text extraction
        textRecognizer.process(image) {result, error in
            guard error == nil, let result = result else {
                //...
                return
            }
            let resultText = result.text
            print(resultText)
            self.textExtract.text = resultText
        }

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


