//
//  SettingsVC.swift
//  SnapchatClone
//
//  Created by İSMAİL AÇIKYÜREK on 2.04.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func logout(_ sender: Any) {
        
      
        do {
           try Auth.auth().signOut()
           performSegue(withIdentifier: "toSingVC", sender: nil)
            
        } catch {
            
        }
        
        
    }
    
    

}
