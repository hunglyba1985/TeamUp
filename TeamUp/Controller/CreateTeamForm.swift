//
//  CreateTeamForm.swift
//  TeamUp
//
//  Created by Hung_mobilefolk on 6/12/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import XLForm
import Firebase


let TeamName = "name"
let TeamNumberOfMember = "numberOfMember"
let TeamStadiumToPlay = "stadiumToPlay"
let TeamTimePlay = "timePlay"
let TeamReadyMember = "readyMembers"

class CreateTeamForm: XLFormViewController {

    fileprivate struct Tags {
        static let Name = TeamName
        static let NumberMember = TeamNumberOfMember
        static let StadiumToPlay = TeamStadiumToPlay
        static let TimePlay = TeamTimePlay
        static let ReadyMember = TeamReadyMember
        
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

    
    func initializeForm() {
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "Team name")
        form.assignFirstResponderOnShow = false
        
        section = XLFormSectionDescriptor.formSection(withTitle: "")
        //        section.footerTitle = "This is a long text that will appear on section footer"
        form.addFormSection(section)
        
        // Team image
        row = XLFormRowDescriptor(tag: Tags.ProfilePlayer, rowType: CustomCellWithNib,title:"Team image")
        section.addFormRow(row)

        
        // Name
        row = XLFormRowDescriptor(tag: Tags.Name, rowType: XLFormRowDescriptorTypeText, title: "Name: ")
        row.isRequired = true
        section.addFormRow(row)
        
        
        // Play Time
        row = XLFormRowDescriptor(tag: Tags.TimePlay, rowType: XLFormRowDescriptorTypeTimeInline, title: "Play time: ")
        row.cellConfigAtConfigure["minuteInterval"] = 15
        row.value = Date()
        section.addFormRow(row)
        
        // Number member
        row = XLFormRowDescriptor(tag: Tags.NumberMember, rowType: XLFormRowDescriptorTypeNumber, title: "Number member: ")
        section.addFormRow(row)
        
        
        // Stadium to play
        row = XLFormRowDescriptor(tag: Tags.StadiumToPlay, rowType: XLFormRowDescriptorTypeText, title: "Stadium to play: ")
        section.addFormRow(row)
        
        
        
        self.form = form
        
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // change cell height of a particular cell
        if form.formRow(atIndex: indexPath)?.tag == Tags.ProfilePlayer {
            return 150
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
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
