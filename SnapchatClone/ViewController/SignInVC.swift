//
//  ViewController.swift
//  SnapchatClone
//
//  Created by İSMAİL AÇIKYÜREK on 2.04.2022.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var showHide = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    @IBAction func singInBtn(_ sender: Any) {
       
        if  passwordText.text != "" && emailText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
                if error != nil {
                    self.makeAlert(message: error!.localizedDescription)
                } else {
                    
                  
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            self.makeAlert(message: "password/email?")
        }
    }
    
    
    
    
    @IBAction func singUpBtn(_ sender: Any) {
        //user Cretion
        if usernameText.text != "" && passwordText.text != "" && emailText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
                if error != nil {
                    self.makeAlert(message: error!.localizedDescription)
                } else {
                    let fireStore = Firestore.firestore()
                    let userDictionary = ["email" : self.emailText.text!, "username" : self.usernameText.text] as [String : Any]
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { error in
                        if error != nil {
                            self.makeAlert(message: error!.localizedDescription)
                        }
                    }
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            self.makeAlert(message: "Username/Password ?")
            
        }
    }
    
    
    func makeAlert( message : String) {
        let alert = UIAlertController(title:"Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButon = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert,animated: true)
        
    }
    
    
    @IBAction func showHideBtn(_ sender: Any) {
        
        if showHide == 1 {
            passwordText.isSecureTextEntry = true
            showHide = 0
        } else if passwordText.isSecureTextEntry == true {
            passwordText.isSecureTextEntry = false
           showHide = 1
            
        }
        
        
        
    }
    
    
}

