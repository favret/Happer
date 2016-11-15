//
//  SignUpVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {

    // MARK: - properties
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    @IBOutlet weak var confpassField: UITextField!
    var authentInteractor = AuthentInteractor()
    // MARK: - parent.methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginField.delegate = self
        self.mailField.delegate = self
        self.passwdField.delegate = self
        self.confpassField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view, typically from a nib.
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "loginBackground")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AuthentPresenter.register(self, events: .SubscribeSuccess, .SubscribeFailure)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        AuthentPresenter.unregisterAll(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    // MARK: - self.methods

    func checkFields() -> Bool {
        if loginField.text == "" || mailField.text == "" || passwdField.text == "" || confpassField.text == "" {
            return false
        }
        return true
    }
    
    @IBAction func submit(sender: UIButton) {
        if !checkFields() {
            loginField.text = ""
            mailField.text = ""
            passwdField.text = ""
            confpassField.text = ""
        }
        if passwdField.text!.lowercaseString == confpassField.text!.lowercaseString {
            print("match")
        }
        else {
            loginField.text = ""
            mailField.text = ""
            passwdField.text = ""
            confpassField.text = ""
            return
        }
        authentInteractor.subscribe(loginField.text!, pass: passwdField.text!, mail: mailField.text!)
        
//        let login = loginField.text!.lowercaseString as NSString
//        let mail = mailField.text!.lowercaseString as NSString
//        let passwd = passwdField.text!.lowercaseString as NSString
//        
//        let session = NSURLSession.sharedSession()
//        var jsonData = NSDictionary()
//        let postr = NSString(string : "login=\(login)&passwd=\(passwd)&mail=\(mail)")
//        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/adduser.php")
//        let request = NSMutableURLRequest(URL :url!)
//        request.HTTPMethod = "POST"
//        
//        let postData: NSData = postr.dataUsingEncoding(NSUTF8StringEncoding)!
//        request.HTTPBody = postData
//        
//        
//        let postLength: NSString = String(postData.length)
//        
//        
//        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        
//        var urlData: NSData?
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            urlData = data! as NSData
//            let res = response as! NSHTTPURLResponse
//            if res.statusCode >= 200 && res.statusCode < 300 {
//                do
//                {
//                    jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                }
//                catch
//                {
//                    print("Catch-Location:: 'signUpVC' :: Serialization of server's response <jsonData>")
//                    return
//                }
//            }
//            else {
//                print(res.statusCode)
//                return
//            }
//            print(jsonData)
//            let success = jsonData.valueForKey("success") as! NSInteger
//            if (success > 0) {
//                print("SUCCESS")
//                let story = UIStoryboard(name: "Main", bundle: nil)
//                let vc = story.instantiateViewControllerWithIdentifier("mainPage") as! MainPageVC
//                self.presentViewController(vc, animated: true, completion: nil)
//            }
//            else {
//                print("FAIL")
//            }
//        })
//        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension SignUpVC : AuthentEvent {
    func subscribeSuccess() {
        print("success")
    }
    
    func subscribeFailure(error: NSError) {
        print("failure")
    }
}
