//
//  ViewController.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/26/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

import UIKit

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

    
