//
//  RegisterViewController.swift
//  TeamUp
//
//  Created by Hung_mobilefolk on 5/23/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKLoginKit
import Firebase


class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var registerFacebook: UIButton!
    
    
    @IBAction func registerFacebookClick(_ sender: Any) {
        print("click log in with facebook ")
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if error != nil {
//                self.showMessagePrompt(error.localizedDescription)
            } else if result!.isCancelled {
                print("FBLogin cancelled")
            } else {
                // [START headless_facebook_auth]
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                // [END headless_facebook_auth]
                self.firebaseLogin(credential)
            }
        })

    }
    
    
    func firebaseLogin(_ credential: FIRAuthCredential) {

        if let user = FIRAuth.auth()?.currentUser {
            // [START link_credential]
            user.link(with: credential) { (user, error) in
                // [START_EXCLUDE]
             
                
                // [END_EXCLUDE]
            }
            // [END link_credential]
        } else {
            // [START signin_credential]
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                // [START_EXCLUDE]
              
            }
        }

    }

    
    @IBAction func getUserInfo(_ sender: Any) {
        
        let user = FIRAuth.auth()?.currentUser

        print("user email is",user?.email)
        print("user icon url is",user?.photoURL)
        print("user id is ",user?.uid)

        
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
