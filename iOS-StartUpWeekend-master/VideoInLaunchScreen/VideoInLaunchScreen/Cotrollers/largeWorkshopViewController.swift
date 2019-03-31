//
//  largeWorkshopViewController.swift
//  startUp
//
//  Created by Mladen Penev on 24.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Firebase

class largeWorkshopViewController: UIViewController {
    
    var value: Int?
    
    func toInt(s: String?) -> Int {
        var result = 0
        if let str: String = s,
            let i = Int(str) {
            result = i
        }
        return result
    }
   
    
    var ref:DatabaseReference!
    var userHandle: DatabaseHandle?
   
    @IBOutlet weak var signInOut: UIButton!
    
    var finalCell:Int = -1
    var userNameCheating = [String]()
    var finalWorkshop: Workshops?
    var finalUser: Users?
    
    @IBOutlet weak var speakerImg: UIImageView!
    @IBOutlet weak var maxEnrolled: UILabel!
    
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var workshopDescription: UITextView!
    
    
    @IBOutlet weak var currEnrolled: UILabel!
    @IBOutlet weak var workShopTitle: UILabel!
    
    @IBAction func signInOutClick(_ sender: UIButton) {
        
        ref=Database.database().reference()
        
        let wshNum = String(finalCell+1)
        
        
        
        let uID = Auth.auth().currentUser?.uid //gets currently logged UID
        
        _ = ref?.child("Users").child(uID!).observe( .value, with: { (snapshot) in // this is very ugly, I apologize
        
            
        })
        
    
        //print("e sq ta hvanah, mrasni usare - \(self.userIDCheating.text)")
        _ = ref?.child("workshops_uploads").child("Workshop" + wshNum).observeSingleEvent(of: .value, with: { (snapshot) in
            let enrollSnap = snapshot.childSnapshot(forPath: "currentlyEnrolled")
        
            if self.signInOut.titleLabel?.text == "Sign In" && self.toInt(s: enrollSnap.value as? String) < self.toInt(s: self.finalWorkshop?.getCapacity()){ //checks the button state
            let commitValue = String(self.toInt(s: enrollSnap.value as? String)+1)
            self.ref.child("workshops_uploads").child("Workshop" + wshNum).child("currentlyEnrolled").setValue(commitValue)
                self.ref.child("EnrolledinWorkshop" + wshNum).child(uID!).setValue(["name": self.finalUser?.getName()]) // testing write
            self.currEnrolled.text = "Enrolled: " + commitValue
            self.signInOut.setTitle("Sign Out", for: .normal)
        }
        else //switches the button back
        {
            let commitValue = String(self.toInt(s: enrollSnap.value as? String)-1)
            self.ref.child("workshops_uploads").child("Workshop" + wshNum).child("currentlyEnrolled").setValue(commitValue)
            self.currEnrolled.text = commitValue
            self.ref.child("EnrolledinWorkshop" + wshNum).child(uID!).removeValue()
            self.currEnrolled.text = "Enrolled: " + commitValue
            self.signInOut.setTitle("Sign In", for: .normal)
        }
        
        })
       
        
 

        
}
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.speakerImg.image=finalWorkshop?.getImage()
        self.currEnrolled.text="Enrolled: " + (finalWorkshop?.getCurEnrolled())!
        self.maxEnrolled.text="Capacity: " + (finalWorkshop?.getCapacity())!
        self.startTime.text="Start Time: " + (finalWorkshop?.getTime())!
        self.workShopTitle.text=finalWorkshop?.getTopic()
        self.speakerName.text=finalWorkshop?.getName()
        self.workshopDescription.text=finalWorkshop?.getDescription()
        
        self.speakerImg.layer.borderWidth = 1
        self.speakerImg.layer.masksToBounds = false
        self.speakerImg.layer.borderColor = UIColor.black.cgColor
        self.speakerImg.layer.cornerRadius = speakerImg.frame.height/2
        self.speakerImg.clipsToBounds = true
     
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let wshNum = String(finalCell+1)
        ref=Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        
        ref?.child("EnrolledinWorkshop" + wshNum).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            if snapshot.hasChild(uid!){
                self.signInOut.setTitle("Sign Out", for: .normal)
                print("ti si true")
            }
            else{
                self.ref?.child("Users").child(uid!).observeSingleEvent(of: .value, with: {(userData) in
                    
                    self.finalUser = Users(snapshot: userData)
                })
                print("ti si false")
            }
    })
}
}
