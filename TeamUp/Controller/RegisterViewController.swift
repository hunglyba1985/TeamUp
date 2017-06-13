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
import SDWebImage


class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.imageView.sd_setImage(with: NSURL.init(string: "https://firebasestorage.googleapis.com/v0/b/teamup-8fe54.appspot.com/o/AaFFbuAkKLYaHydUz5wfyH9X0tK2%2F517995028054.jpg?alt=media&token=72fb140a-c4e2-4b14-a5ce-c1a5ee8665d1")! as URL)
    }

    
    
    @IBAction func pushToAnotherView(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let anotherView = storyboard.instantiateViewController(withIdentifier: "FormViewSwitf")
        self.navigationController?.pushViewController(anotherView, animated: true)
        
    }
    
    
    @IBAction func showPlayerInfo(_ sender: Any) {
        
        let playerInfo = PlayerProfileViewController()
        self.navigationController?.pushViewController(playerInfo, animated: true)
        
        
    }
    
    @IBOutlet weak var createTeamAction: UIButton!
    
    @IBAction func createTeam(_ sender: Any) {
        
        let teamForm = CreateTeamForm()
        self.navigationController?.pushViewController(teamForm, animated: true)
    }
    
   


    
    func testRegisterWithPhone()
    {
        
    }
    
    @IBOutlet weak var registerFacebook: UIButton!
    
    
    @IBAction func registerFacebookClick(_ sender: Any) {
        print("click log in with facebook ")
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if error != nil {
//                self.showMessagePrompt(error.localizedDescription)
                
                print(error)
                
                
            } else if result!.isCancelled {
                print("FBLogin cancelled")
            } else {
                // [START headless_facebook_auth]
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                // [END headless_facebook_auth]
                self.firebaseLogin(credential)
            }
        })

    }
    
    
    func firebaseLogin(_ credential: AuthCredential) {

        if let user = Auth.auth().currentUser {
            // [START link_credential]
            user.link(with: credential) { (user, error) in
                // [START_EXCLUDE]
             
                if error != nil {
                    print(error)
                }
                // [END_EXCLUDE]
            }
            // [END link_credential]
        } else {
            // [START signin_credential]
            Auth.auth().signIn(with: credential) { (user, error) in
                // [START_EXCLUDE]
              
                if error != nil {
                    print(error)
                }
                else
                {
                    print("successful")
                    
                }
            }
        }

    }

    
    @IBAction func getUserInfo(_ sender: Any) {
        
        let user = Auth.auth().currentUser

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
