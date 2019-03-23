//
//  RegController.swift
//  startUp
//
//  Created by Mladen Penev on 10.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

class RegController: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passTxt: UITextField! //ticket number
    
    var ref:DatabaseReference!
    var databaseHande:DatabaseHandle?

    @IBAction func registerClick(_ sender: UIButton) {
        
        
        let username=userNameTxt.text
        let email = emailTxt.text
        let password = passTxt.text
        var isVerified = false
        ref=Database.database().reference()
        
        databaseHande = ref?.child("Keys").observe(.value, with: { (snapshot) in
           
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let imageSnap = snap.childSnapshot(forPath: "key")
                if  (password?.count == 6 && password == imageSnap.value as? String && username!.count != 0 && isValidEmail(testStr: email!)){
                    isVerified = true
                    break
                }
                else{
                    isVerified = false
                    
                }
            }
            print("Kurec\(isVerified)")
        })
        
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
