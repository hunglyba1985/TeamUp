//
//  PlayerProfileViewController.swift
//  TeamUp
//
//  Created by Macbook Pro on 6/10/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import XLForm
import Firebase
import SDWebImage



class PlayerProfileViewController: XLFormViewController {

    // [START define_database_reference]
    var ref: DatabaseReference!
    // [END define_database_reference]
    
    
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
        
        
        row = XLFormRowDescriptor(tag: Tags.ProfilePlayer, rowType: CustomCellWithNib)
        section.addFormRow(row)
        
        
        // Name
        row = XLFormRowDescriptor(tag: Tags.Name, rowType: XLFormRowDescriptorTypeInfo, title: "Name: ")
        section.addFormRow(row)
        
        // Age
        row = XLFormRowDescriptor(tag: Tags.Age, rowType: XLFormRowDescriptorTypeInfo, title: "Age: ")
        section.addFormRow(row)
        
        // Height
        row = XLFormRowDescriptor(tag: Tags.Height, rowType: XLFormRowDescriptorTypeInfo, title: "Height (m): ")
        section.addFormRow(row)
        
        // Weight
        row = XLFormRowDescriptor(tag: Tags.Weight, rowType: XLFormRowDescriptorTypeInfo, title: "Weight (kg): ")
        section.addFormRow(row)
        
        // Phone number
        row = XLFormRowDescriptor(tag: Tags.PhoneNumber, rowType: XLFormRowDescriptorTypeInfo, title: "Phone number: ")
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
//        row.selectorOptions = playPositions
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
        
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        
        section = XLFormSectionDescriptor.formSection(withTitle: "Hobby")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.Hobby, rowType: XLFormRowDescriptorTypeTextView, title: "Hobby")
        section.addFormRow(row)
        
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
//        // Save Button
//        row = XLFormRowDescriptor(tag: Tags.SaveButton, rowType: XLFormRowDescriptorTypeButton, title: "Save")
//        row.cellConfig["textLabel.textColor"] = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
//        row.action.formSelector = #selector(savePlayerInfoToFirebase(_:))
//        
//        section.addFormRow(row)
        
        
        self.form = form
        
        
        form.isDisabled = true

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // [START create_database_reference]
        ref = Database.database().reference()
        // [END create_database_reference]
        
        self.getDataFromFirebase()
        
    }
    
    func getDataFromFirebase()
    {
        let userID = Auth.auth().currentUser?.uid
        ref.child(PlayerProfile).child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
             let value = snapshot.value as? NSDictionary
//            let playerAvatarUrl = value?[PlayerAvatarUrl] as! String
//            print("player name is ",playerAvatarUrl)
            
//            let row = self.form.formRow(withTag: Tags.Name)
//            row?.value = playerName
//            self.reloadFormRow(row)

//            print("data get from firebase",snapshot)
//
//            guard let playerData = Player.init(snapshot: snapshot) else { return  }
//            
//            print("player name is",playerData.name)
//            
            self.setDataForPlayer(playerData: value!)
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func setDataForPlayer(playerData: NSDictionary)
    {
        let playerAvatarUrl = playerData[PlayerAvatarUrl] as! String
        SDWebImageManager.shared().imageDownloader?.downloadImage(with:  NSURL(string:playerAvatarUrl) as URL!, options: SDWebImageDownloaderOptions.allowInvalidSSLCertificates, progress: { (min, max, url) in
            //                print("loading……")
        }, completed: { (image, data, error, finished) in
            if image != nil {
                print("finished")
                
                let row = self.form.formRow(withTag: Tags.ProfilePlayer)
                row?.value = image
                self.reloadFormRow(row)
                
            } else {
                print("wrong")
            }
        })
        
        let playerName = playerData[PlayerName] as! String

        let row = self.form.formRow(withTag: Tags.Name)
        row?.value = playerName
        self.reloadFormRow(row)
        
        
     

        

        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // change cell height of a particular cell
        if form.formRow(atIndex: indexPath)?.tag == Tags.ProfilePlayer {
            return 150
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
