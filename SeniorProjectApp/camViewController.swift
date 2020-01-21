//
//  camViewController.swift
//  SeniorProjectApp
//
//  Created by Gaurav Karkhanis on 1/9/20.
//  Copyright © 2020 Gaurav Karkhanis. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class camViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let imageController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageController.sourceType = UIImagePickerController.SourceType.camera
       // imageController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imageController.delegate = self


        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photoCapture(_ sender: Any) {
        present(imageController, animated: true, completion: nil)
    }
}
    
    


extension camViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        //imageView.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("The camera has been closed")
    }
}
extension camViewController: UINavigationControllerDelegate {
}

