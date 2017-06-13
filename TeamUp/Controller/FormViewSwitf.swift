//
//  FormViewSwitf.swift
//  TeamUp
//
//  Created by Hung_mobilefolk on 5/29/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import XLForm
import Firebase


class FormViewSwitf: XLFormViewController {

    var ref: DatabaseReference!
    var storageRef: StorageReference!

    
    fileprivate struct Tags {
        static let Name = "name"
        static let Age = "age"
        static let Height = "height"
        static let Weight = "weight"
        static let PhoneNumber = "phone number"
        static let Location = "location"
        static let Work = "work"
        static let PlayPosition = "play position"
        static let FavoriteClub = "favorite club"
        static let SpareTime = "spare time"
        static let JoinStatus = "join status"
        static let Hobby = "hobby"
        static let ProfilePlayer = "profile player"
        static let SaveButton = "save button"
    }
    
    let playPositions = ["Goalkeeper","Defender center","Left back","Right back","Midfielder center","Left wing","Right wing","Attacker"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initializeForm()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeForm()
    }
    
    
    // MARK: Helpers
    
    func initializeForm() {
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "Player name")
        form.assignFirstResponderOnShow = false
        
        section = XLFormSectionDescriptor.formSection(withTitle: "")
//        section.footerTitle = "This is a long text that will appear on section footer"
        form.addFormSection(section)
        
        
        // Player image
        row = XLFormRowDescriptor(tag: Tags.ProfilePlayer, rowType: CustomCellWithNib, title: "Player image")
        section.addFormRow(row)

        
        // Name
        row = XLFormRowDescriptor(tag: Tags.Name, rowType: XLFormRowDescriptorTypeText, title: "Name: ")
        row.isRequired = true
        section.addFormRow(row)
        
        // Age
        row = XLFormRowDescriptor(tag: Tags.Age, rowType: XLFormRowDescriptorTypeNumber, title: "Age: ")
        section.addFormRow(row)
        
        // Height
        row = XLFormRowDescriptor(tag: Tags.Height, rowType: XLFormRowDescriptorTypeNumber, title: "Height (m): ")
        section.addFormRow(row)
        
        // Weight
        row = XLFormRowDescriptor(tag: Tags.Weight, rowType: XLFormRowDescriptorTypeNumber, title: "Weight (kg): ")
        section.addFormRow(row)
        
        // Phone number
        row = XLFormRowDescriptor(tag: Tags.PhoneNumber, rowType: XLFormRowDescriptorTypeNumber, title: "Phone number: ")
        section.addFormRow(row)
        
        // Location
        // Another Button using StoryboardId
        row = XLFormRowDescriptor(tag: Tags.Location, rowType: XLFormRowDescriptorTypeButton, title: "Location")
        row.action.viewControllerStoryboardId = "MapViewController"
        section.addFormRow(row)
        
        // Work
        row = XLFormRowDescriptor(tag: Tags.Work, rowType: XLFormRowDescriptorTypeText, title: "Work: ")
        section.addFormRow(row)
        
        // Position play
        row = XLFormRowDescriptor(tag: Tags.PlayPosition, rowType:XLFormRowDescriptorTypeMultipleSelector, title:"Play positions:")
        row.selectorOptions = playPositions
        section.addFormRow(row)

        
        // Favorite club
        row = XLFormRowDescriptor(tag: Tags.FavoriteClub, rowType: XLFormRowDescriptorTypeText, title: "Favorite club: ")
        section.addFormRow(row)
        
        // Spare time
        // Time
        row = XLFormRowDescriptor(tag: Tags.SpareTime, rowType: XLFormRowDescriptorTypeTimeInline, title: "Spare time: ")
        row.cellConfigAtConfigure["minuteInterval"] = 15
        row.value = Date()
        section.addFormRow(row)

        // Switch
        section.addFormRow(XLFormRowDescriptor(tag: Tags.JoinStatus, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Join status"))
        
        // Hobby
        row = XLFormRowDescriptor(tag: Tags.Hobby, rowType: XLFormRowDescriptorTypeTextView, title: "Hobby")
        section.addFormRow(row)
        
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        // Save Button
        row = XLFormRowDescriptor(tag: Tags.SaveButton, rowType: XLFormRowDescriptorTypeButton, title: "Save")
        row.cellConfig["textLabel.textColor"] = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        row.action.formSelector = #selector(savePlayerInfoToFirebase(_:))
            
        section.addFormRow(row)
        
        
        self.form = form

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageRef = Storage.storage().reference()
        
        // [START create_database_reference]
        self.ref = Database.database().reference()
        // [END create_database_reference]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // change cell height of a particular cell
        if form.formRow(atIndex: indexPath)?.tag == Tags.ProfilePlayer {
            return 150
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }
        
        return 30
    }
    
    
    override func formRowDescriptorValueHasChanged(_ formRow: XLFormRowDescriptor!, oldValue: Any!, newValue: Any!) {
        super.formRowDescriptorValueHasChanged(formRow, oldValue: oldValue, newValue: newValue)
        
        if formRow.tag == Tags.ProfilePlayer {
            
            print("old value is ",oldValue)
            
            print("new value is ",newValue )
            
        }
        
    }
    
    func savePlayerInfoToFirebase(_ sender: XLFormRowDescriptor)
    {
        print("save data to firebase")
        self.deselectFormRow(sender)

        let formValue = form.formValues() as NSDictionary
        let image = formValue[Tags.ProfilePlayer] as! UIImage
        
        self.postImageToFirebase(image: image)
        

    }

    func postImageToFirebase(image: UIImage)
    {
        guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
        let imagePath = Auth.auth().currentUser!.uid +
        "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        self.storageRef.child(imagePath).putData(imageData, metadata: metadata) { (metadata,error) in
            if let error = error {
                print("Error uploading :\(error)")
                return
            }
            self.uploadImageSuccess(metadata!, storagePath: imagePath)
            
        }
        
    }
    
    func uploadImageSuccess(_ metadata: StorageMetadata, storagePath: String) {
        print("Upload Succeeded!")
//        self.urlTextView.text = metadata.downloadURL()?.absoluteString
        
        print("download image url is \(String(describing: metadata.downloadURLs))")

        
//        UserDefaults.standard.set(storagePath, forKey: "storagePath")
//        UserDefaults.standard.synchronize()
//        self.downloadPicButton.isEnabled = true
        
        print("storage path is ",storagePath)
        
        // [START single_value_read]
        let userID = Auth.auth().currentUser?.uid
        
        self.createNewPlayerData(withUserID: userID!, userName: "", avatarUlr: (metadata.downloadURL()?.absoluteString)!)

    }

    
    func createNewPlayerData(withUserID userID: String, userName: String, avatarUlr: String)
    {
        print("create new child in database")
        
        let formValue = form.formValues() as NSDictionary

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let time = formValue[Tags.SpareTime] as! NSDate
        
        let timeString = formatter.string(from: time as Date)
        
        
//        let key = ref.child("Player").childByAutoId().key
        let post = [PlayerUid: userID,
                    PlayerName: formValue[Tags.Name],
                    PlayerAge:formValue[Tags.Age] ,
                    PlayerHeight:formValue[Tags.Height] ,
                    PlayerWeight:formValue[Tags.Weight] ,
                    PlayerPhoneNumber:formValue[Tags.PhoneNumber],
                    PlayerLocation:formValue[Tags.Location],
                    PlayerWork:formValue[Tags.Work],
                    PlayerPlayPosition:formValue[Tags.PlayPosition],
                    PlayerFavoriteClub:formValue[Tags.FavoriteClub],
                    PlayerSpareTime:timeString,
                    PlayerJoinStatus:formValue[Tags.JoinStatus],
                    PlayerHobby:formValue[Tags.Hobby],
                    PlayerAvatarUrl:avatarUlr
                    ]
        
        let childUpdate = ["/Player/\(userID)":post]
        
        ref.updateChildValues(childUpdate)
        
    }

}









