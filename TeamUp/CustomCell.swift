//
//  CustomCell.swift
//  SwiftExample
//
//  Created by Hung_mobilefolk on 5/30/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import UIKit
import XLForm

let CustomCellWithNib = "CustomCellWithNib"

class CustomCell: XLFormBaseCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var playerImage: UIImageView!
    
    override func configure() {
        super.configure()
        selectionStyle = .none
        
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
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Button capture")
            let  imagePicker = UIImagePickerController()

            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            
            self.formViewController().present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //PickerView Delegate Method
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        playerImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker cancel.")
        picker.dismiss(animated: true, completion: nil)
        
    }

  
      
}
