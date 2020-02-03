//
//  RootViewController.swift
//  TestingSaveImageMania
//
//  Created by Alex Nagy on 14/04/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import TinyConstraints
import FirebaseStorage
import FirebaseFirestore
import Kingfisher
import FirebaseMLVision

struct MyKeys {
    static let imagesFolder = "imagesFolder"
    static let imagesCollection = "imagesCollection"
    static let uid = "uid"
    static let imageUrl = "imageUrl"
}

class RootViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var imageViewExample: UIImageView!
    
    @IBOutlet weak var extractedExample: UILabel!
    
    lazy var takePhotoBarButtonItem = UIBarButtonItem(title: "Take", style: .done, target: self, action: #selector(takePhoto))
    
    lazy var savePhotoBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePhoto))
    
    lazy var uploadPhotoBarButtonItem = UIBarButtonItem(title: "Upload", style: .done, target: self, action: #selector(uploadPhoto))
    
    lazy var downloadPhotoBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(downloadPhoto))
    
    lazy var stripTextBarButtonItem = UIBarButtonItem(title: "Strip", style: .plain, target: self, action: #selector(mLAnalysis))
    
    lazy var imagePickerController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        return controller
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationItem()
        setupViews()
    
        self.view.addSubview(extractedExample)


    }
    
    fileprivate func setupNavigationItem() {
        navigationItem.setLeftBarButtonItems([takePhotoBarButtonItem, savePhotoBarButtonItem, stripTextBarButtonItem], animated: false)
        navigationItem.setRightBarButtonItems([uploadPhotoBarButtonItem, downloadPhotoBarButtonItem], animated: false)
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(activityIndicator)
        
        imageView.edgesToSuperview()
        activityIndicator.centerInSuperview()
    }
    
    /*@objc func mLAnalysis() {
        var capturedImage: UIImage = imageView.image!
        
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
            let str = resultText
            let filename = self.getDocumentsDirectory().appendingPathComponent("output.txt")

            do {
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            }
            
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
 */
    
    @objc func mLAnalysis() {
        var capturedImage: UIImage = imageViewExample.image!
        
        
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
            self.extractedExample.text = resultText
        }
    }

    @objc fileprivate func takePhoto() {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc fileprivate func savePhoto() {
        // add code here
        guard let image = imageView.image else { return }
        
        //UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        saveToAlbum(named: "Receipt Collection", image: image)
    }
    
    @objc fileprivate func uploadPhoto() {
        // add code here
        activityIndicator.startAnimating()
        
        //guard let image = imageView.image, let data = image.jpegData(compressionQuality: 1.0) else {
        guard let image = imageView.image, let data = image.jpegData(compressionQuality: 1)
            else {
            presentAlert(title: "Error", message: "Something went wrong")
            return
        }
        
        let imageName = UUID().uuidString
        
        let imageReference = Storage.storage().reference().child(MyKeys.imagesFolder).child(imageName)
        
        imageReference.putData(data, metadata: nil) { (metadata, err) in
            if let err = err {
                self.presentAlert(title: "Error", message: err.localizedDescription)
                return
            }
            
            imageReference.downloadURL { (url, err) in
                if let err = err {
                self.presentAlert(title: "Error", message: err.localizedDescription)
                return
                }
                
                guard let url = url else {
                    self.presentAlert(title: "Error", message: "Something went wrong")
                    return
                }
                
                let dataReference = Firestore.firestore().collection(MyKeys.imagesCollection).document()
                let documentUid = dataReference.documentID
                
                let urlString = url.absoluteString
                
                let data = [
                    MyKeys.uid: documentUid,
                    MyKeys.imageUrl: urlString
                ]
                
                dataReference.setData(data) { (err) in
                    if let err = err {
                        self.presentAlert(title: "Error", message: err.localizedDescription)
                        return
                    }
                    
                    UserDefaults.standard.set(documentUid, forKey: MyKeys.uid)
                    self.imageView.image = UIImage()
                    self.presentAlert(title: "Success", message: "Successfully sent image to Firebase database")
                }
                
            }
        }
                
    }
    
    @objc fileprivate func downloadPhoto() {
        // add code here
        activityIndicator.startAnimating()
        
        guard let uid = UserDefaults.standard.value(forKey: MyKeys.uid) else {
            self.presentAlert(title: "Error", message: "Something went wrong")
            return
        }
        
        let query = Firestore.firestore().collection(MyKeys.imagesCollection).whereField(MyKeys.uid, isEqualTo: uid)
        
        query.getDocuments { (snapshot, err) in
            if let err = err {
            self.presentAlert(title: "Error", message: err.localizedDescription)
            return
            }
            guard let snapshot = snapshot, let data = snapshot.documents.first?.data(),
                let urlString = data[MyKeys.imageUrl] as? String,
                let url = URL(string: urlString)  else {
                self.presentAlert(title: "Error", message: "Something went wrong")
                return
            }
            
            let resource = ImageResource(downloadURL: url)
            self.imageView.kf.setImage(with: resource, completionHandler: { (result) in
                switch result {
                    
                case .success(_):
                    self.presentAlert(title: "Success", message: "Successfully downloaded image from database")
                case .failure(let err):
                    self.presentAlert(title: "Error", message: err.localizedDescription)
                @unknown default:
                    print("It looks like Apple has added a new a new case here...")
                }
            })
        }
    }
    
    func saveToAlbum(named: String, image: UIImage) {
        let album = CustomAlbum(name: named)
        album.save(image: image) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(_): break
                self.presentAlert(title: "Success", message: "Successfully save photo to album \"\(named)\"")
                case .failure(let err):
                    self.presentAlert(title: "Error", message: err.localizedDescription)
                    
                }
            }
            
        }
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError err: Error?, contextInfo: UnsafeRawPointer) {
        activityIndicator.stopAnimating()
        if let err = err {
            // we got back an error!
            presentAlert(title: "Error", message: err.localizedDescription)
        } else {
            presentAlert(title: "Saved!", message: "Image saved successfully")
        }
    }
    
    func presentAlert(title: String, message: String) {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

extension RootViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imageView.image = selectedImage
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}


