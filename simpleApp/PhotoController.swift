//
//  PhotoController.swift
//  simpleApp
//
//  Created by Son Dinh on 9/13/19.
//  Copyright © 2019 Son Dinh. All rights reserved.
//

import UIKit
import TesseractOCR
import GPUImage


class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    var parentVC: ViewController?
    @IBOutlet weak var photoButton: UIBarButtonItem!
    @IBOutlet weak var photoViewer: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var delegate: PhotoControllerDelegate?
    
    var demo = [Transaction]()
    var count : Int!
    
    var update: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Check Camera is ready:
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.photoButton.isEnabled = true
        }
        else {
            self.photoButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    @IBAction func saveImage(_ sender: UIBarButtonItem){
        save()
        let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func takePhoto(_ sender: Any){
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .camera
        self.present(photoController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.photoViewer.image = image
            textRecognition(image)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Tesseract OCR:
    func textRecognition(_ image: UIImage){
        let scaledImage = image.scaledImage(1000) ?? image
        let preprocessedImage = scaledImage.preprocessedImage() ?? scaledImage
        
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.engineMode = .tesseractCubeCombined
            tesseract.pageSegmentationMode = .auto
            
            tesseract.image = preprocessedImage
            tesseract.recognize()
            print("Recognize Text: \(tesseract.recognizedText!)")
        }
    }
    
    // MARK: - save image content
    func save(){
        getFromFile()
        self.update = self.demo[self.count]
        delegate?.PhotoControllerWillDismiss(update: self.update!, image: self.photoViewer.image!)
    }
}

extension UIImage {
    func scaledImage(_ maxDimension: CGFloat) -> UIImage? {
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            scaledSize.height = size.height / size.width * scaledSize.width
        } else {
            scaledSize.width = size.width / size.height * scaledSize.height
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func preprocessedImage() -> UIImage? {
        let stillImageFilter = GPUImageAdaptiveThresholdFilter()
        stillImageFilter.blurRadiusInPixels = 15.0
        let filteredImage = stillImageFilter.image(byFilteringImage: self)
        return filteredImage
    }
}

//class OCR_text {
//    var content: String
//    var line: Int
//}

extension PhotoController {
    func getFromFile(){
        let path: NSString = Bundle.main.path(forResource: "demo",
                                              ofType: "json")! as NSString
        let data : NSData = try! NSData(contentsOfFile: path as String,
                                        options: NSData.ReadingOptions.dataReadingMapped)
        let user = try! JSONDecoder().decode(Result.self, from: data as Data)
        self.demo = user.transactions
    }
}

protocol PhotoControllerDelegate {
    func PhotoControllerWillDismiss(update: Transaction, image: UIImage)
}
