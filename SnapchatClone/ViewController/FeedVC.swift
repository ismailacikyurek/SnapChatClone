//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by İSMAİL AÇIKYÜREK on 2.04.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let fireStoreDatabase = Firestore.firestore()
    var snapArray = [snap]()
    var chosenSnap : snap?
    var timeleft : Int?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getSnapsFromFirebase()
        getUserinFo()
    }
    
    
    func getUserinFo() {
        
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo : Auth.auth().currentUser?.email).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(message: error?.localizedDescription ?? "error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil  {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            UserSingleton.SharedUSerInfo.email = (Auth.auth().currentUser?.email)!
                            UserSingleton.SharedUSerInfo.username = username
                    }
                }
            }
        }
        
    }
}
   
    func makeAlert( message : String) {
        let alert = UIAlertController(title:"Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButon = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert,animated: true)
        
    }
    
    
    
    
    func getSnapsFromFirebase() {
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(message: error?.localizedDescription ?? "error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        if difference >= 24 {
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete()
                                        }
                                        //timeLeft ->SnapVC
                                        
                                        self.timeleft = 24 - difference
                                        
                                    }
                                    
                                    let snap = snap(username: username, imageURlArray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
    cell.feedUsernameLabel.text = snapArray[indexPath.row].username
    cell.feedimageView.sd_setImage(with : URL(string: snapArray[indexPath.row].imageURlArray[0]))
    return cell
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destinationVC = segue.destination as! SnapVC
            destinationVC.selectedNSap = chosenSnap
            destinationVC.SelectedTime = self.timeleft
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
}
