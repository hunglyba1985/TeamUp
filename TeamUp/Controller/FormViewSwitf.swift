//
//  FormViewSwitf.swift
//  TeamUp
//
//  Created by Hung_mobilefolk on 5/29/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import XLForm


class FormViewSwitf: XLFormViewController {

    fileprivate struct Tags {
        static let Name = "name"
        static let Email = "email"
        static let Twitter = "twitter"
        static let Number = "number"
        static let Integer = "integer"
        static let Decimal = "decimal"
        static let Password = "password"
        static let Phone = "phone"
        static let Url = "url"
        static let ZipCode = "zipCode"
        static let TextView = "textView"
        static let Notes = "notes"
        static let SwitchBool = "join status"
        static let ButtonWithStoryboardId = "location"
        static let MultipleSelector = "play positions"
        static let height = "height"
        static let weight = "weight"
        static let TimeInline = "spare time"
        static let ProfilePlayer = "profile player"
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
        form.assignFirstResponderOnShow = true
        
        section = XLFormSectionDescriptor.formSection(withTitle: "Register")
//        section.footerTitle = "This is a long text that will appear on section footer"
        form.addFormSection(section)
        
        
        row = XLFormRowDescriptor(tag: Tags.ProfilePlayer, rowType: CustomCellWithNib)
        section.addFormRow(row)

        
        // Name
        row = XLFormRowDescriptor(tag: Tags.Name, rowType: XLFormRowDescriptorTypeText, title: "Name: ")
        row.isRequired = true
        section.addFormRow(row)
        
        // Age
        row = XLFormRowDescriptor(tag: Tags.Email, rowType: XLFormRowDescriptorTypeNumber, title: "Age: ")
        section.addFormRow(row)
        
        // Height
        row = XLFormRowDescriptor(tag: Tags.height, rowType: XLFormRowDescriptorTypeNumber, title: "Height (m): ")
        section.addFormRow(row)
        
        // Weight
        row = XLFormRowDescriptor(tag: Tags.weight, rowType: XLFormRowDescriptorTypeNumber, title: "Weight (kg): ")
        section.addFormRow(row)
        
        // Phone number
        row = XLFormRowDescriptor(tag: Tags.Name, rowType: XLFormRowDescriptorTypePhone, title: "Phone number: ")
        section.addFormRow(row)
        
        // Location
        // Another Button using StoryboardId
        row = XLFormRowDescriptor(tag: Tags.ButtonWithStoryboardId, rowType: XLFormRowDescriptorTypeButton, title: "Location")
        row.action.viewControllerStoryboardId = "MapViewController"
        section.addFormRow(row)
        
        // Work
        row = XLFormRowDescriptor(tag: Tags.Number, rowType: XLFormRowDescriptorTypeText, title: "Work: ")
        section.addFormRow(row)
        
        // Position play
        row = XLFormRowDescriptor(tag: Tags.MultipleSelector, rowType:XLFormRowDescriptorTypeMultipleSelector, title:"Play positions:")
        row.selectorOptions = playPositions
        section.addFormRow(row)

        
        // Favorite club
        row = XLFormRowDescriptor(tag: Tags.Decimal, rowType: XLFormRowDescriptorTypeText, title: "Favorite club: ")
        section.addFormRow(row)
        
        // Spare time
        // Time
        row = XLFormRowDescriptor(tag: Tags.TimeInline, rowType: XLFormRowDescriptorTypeTimeInline, title: "Spare time: ")
        row.cellConfigAtConfigure["minuteInterval"] = 15
        row.value = Date()
        section.addFormRow(row)

        
//        // Hobby
//        row = XLFormRowDescriptor(tag: Tags.Phone, rowType: XLFormRowDescriptorTypeText, title: "hobby")
//        section.addFormRow(row)
        
//        // Url
//        row = XLFormRowDescriptor(tag: Tags.Url, rowType: XLFormRowDescriptorTypeURL, title: "Url")
//        section.addFormRow(row)
        
        // Switch
        section.addFormRow(XLFormRowDescriptor(tag: Tags.SwitchBool, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Join status"))
        

        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        
//        // Hobby
//        row = XLFormRowDescriptor(tag: Tags.TextView, rowType: XLFormRowDescriptorTypeTextView)
//        row.cellConfigAtConfigure["textView.placeholder"] = "Hobby"
//        section.addFormRow(row)
        
        
        section = XLFormSectionDescriptor.formSection(withTitle: "Hobby")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.Number, rowType: XLFormRowDescriptorTypeTextView, title: "Hobby")
        section.addFormRow(row)
        
        self.form = form

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // change cell height of a particular cell
        if form.formRow(atIndex: indexPath)?.tag == Tags.ProfilePlayer {
            return 100
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    func addToCommitOldCode()
    {
        
    }

}









