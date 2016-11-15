//
//  MainPageVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class MainPageVC: UIViewController, FBSDKLoginButtonDelegate {
    
    // MARK: - properties
    
    @IBOutlet weak var fbLogin: FBSDKLoginButtonFR!
    
    // MARK: - parent.methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fbLogin.readPermissions = ["public_profile", "email", "user_friends"]
        fbLogin.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "loginBackground")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - self.methods
    
    @IBAction func loginButton(sender: UIButton) {
        performSegueWithIdentifier("mainToLogin", sender: self)
    }
    
    @IBAction func signUpButton(sender: UIButton) {
        performSegueWithIdentifier("mainToSignUp", sender: self)
    }
    
    // MARK: - FBSDK methods
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {}
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error != nil
        {
            print(error.localizedDescription)
            return
        }
        else
        {
            let request = FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: ["fields":"email,first_name, last_name, picture"], HTTPMethod: "GET")
            request.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
                if(error == nil)
                {
                    print("result \(result)")
                    let story = UIStoryboard(name: "Main", bundle: nil)
                    let vc = story.instantiateViewControllerWithIdentifier("inspiVC")
                    self.presentViewController(vc, animated: true, completion: nil)
                }
                else
                {
                    print("error \(error)")
                }
            })
        }
    }
}
