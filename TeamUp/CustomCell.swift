//
//  CustomCell.swift
//  SwiftExample
//
//  Created by Hung_mobilefolk on 5/30/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import UIKit
import XLForm
import Firebase

let CustomCellWithNib = "CustomCellWithNib"

class CustomCell: XLFormBaseCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var playerImage: UIImageView!
    var storageRef: StorageReference!

    override func configure() {
        super.configure()
        selectionStyle = .none
        storageRef = Storage.storage().reference()

    }
    
    
    override func update() {
        super.update()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTap(tapGesture:)))
                playerImage.addGestureRecognizer(tapGesture)
//                self.playerImage.image = UIImage.init(named: "new image")
        

    }
    
    func imageTap(tapGesture: UITapGestureRecognizer)
    {
        print("tap to image")
        
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//            print("Button capture")
//            let  imagePicker = UIImagePickerController()
//
//            imagePicker.delegate = self
//            imagePicker.sourceType = .photoLibrary;
//            imagePicker.allowsEditing = false
//            
//            self.formViewController().present(imagePicker, animated: true, completion: nil)
//        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        self.formViewController().present(picker, animated: true, completion:nil)

        
    }
    
    //PickerView Delegate Method
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
//        playerImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        print("get image from any where")
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        let resizeImage = image.resized(withPercentage: 0.2)!
        playerImage.image = resizeImage
        guard let imageData = UIImageJPEGRepresentation(resizeImage, 0.8) else { return }
        let imagePath = Auth.auth().currentUser!.uid +
        "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        self.storageRef.child(imagePath).putData(imageData, metadata: metadata) { (metadata,error) in
            if let error = error {
                print("Error uploading :\(error)")
                return
            }
//            self.uploadSuccess(metadata!, storagePath: imagePath)
            
        }

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker cancel.")
        picker.dismiss(animated: true, completion: nil)
        
    }

  
      
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

