//
//  ViewController.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/26/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

import UIKit
import STTwitter

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* Method called when the login button is pressed, check if the fields are 
       empty and give a warning to the user.
     */
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        guard let user = self.userName.text, user != "" else {
            self.userName.backgroundColor = UIColor.red
            self.warningLabel.isHidden = false
            return
        }
        
        guard let userPassword = self.password.text, userPassword != "" else {
            self.password.backgroundColor = UIColor.red
            self.warningLabel.isHidden = false
            return
        }
        
        let twitter = STTwitterAPI(oAuthConsumerKey: "erRX64spTPkdyzqxbAkW9OFa1",
                                   consumerSecret: "fdys3G9u9OGqoqETty9uxcGtb64YKDaOHxHhenNCRCsoqq1qL5",
                                   oauthToken: "104355235-oBHSRpnycmA5brEQgYwwkTaRlehFneZwlMnYTxP5",
                                   oauthTokenSecret: "DvsQBTuSzsId9cH9tNKgkIziZM0c49vhkUrHtZIuoN819")
        
        twitter!.verifyCredentials(userSuccessBlock: {(username, userId) -> Void
            in
            print(username!, userId!)}) {(error) -> Void in
                print(error!)
        }
        
        // This is not possible at the moment
        /*let twitter = STTwitterAPI(oAuthConsumerName: nil,
                                   consumerKey: "erRX64spTPkdyzqxbAkW9OFa1",
                                   consumerSecret: "fdys3G9u9OGqoqETty9uxcGtb64YKDaOHxHhenNCRCsoqq1qL5",
                                   username: user,
                                   password: userPassword)*/
    
    }
    
    /* When the user start typing this method clean the warning in the test 
       the fields.
     */
    @IBAction func textFieldsEditingDidBegin(_ sender: UITextField) {
                
        sender.backgroundColor = UIColor.white
        if !self.warningLabel.isHidden {
            self.warningLabel.isHidden = true
        }

    }
}

    
