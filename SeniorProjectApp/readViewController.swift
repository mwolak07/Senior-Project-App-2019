//
//  readViewController.swift
//  
//
//  Created by Gaurav Karkhanis on 12/12/19.
//

import UIKit
import Firebase

class readViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var receiptImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func buttonTapped(_ sender: Any) {
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        guard let img = receiptImage.image else { return }
        let goodImage: UIImage = img
        let image = VisionImage(image: goodImage)
        
        textRecognizer.process(image) { result, error in
            guard error == nil, let result = result else {
                // ...
                return
            }
            let resultText = result.text
            self.infoLabel.text = resultText
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
