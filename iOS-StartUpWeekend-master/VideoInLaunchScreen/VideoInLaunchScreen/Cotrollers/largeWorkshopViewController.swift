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
  
    
    @IBOutlet weak var signInOut: UIButton!
    
    var finalSpeakerImage:UIImage? = nil
    var finalCapacityWorkshop = ""
    var finalEnrolledWorkshop = ""
    var finalSpeakerName = ""
    var finalWorkshopTime = ""
    var finalWorkshopTitle = ""
    var finalWorkshopDescription = ""
    var finalCell:Int = -1
    
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
        var nameForEnroll: String!
        
        
        let uID = Auth.auth().currentUser?.uid //gets currently logged UID
        /*let userHande = ref?.child("workshops_uploads").child("Workshop" + wshNum).observeSingleEvent(of: .value, with: { (snapshot) in
            nameForEnroll = snapshot.child(uID).value(value(forKeyPath: "name"))
            }) //gets to the Users child of DB points to
        */
       let databaseHande = ref?.child("workshops_uploads").child("Workshop" + wshNum).observeSingleEvent(of: .value, with: { (snapshot) in
            let enrollSnap = snapshot.childSnapshot(forPath: "currentlyEnrolled")
        
        if self.signInOut.titleLabel?.text == "Sign In" && self.toInt(s: enrollSnap.value as! String) < self.toInt(s: self.finalCapacityWorkshop){ //checks the button state
            let commitValue = String(self.toInt(s: enrollSnap.value as? String)+1)
            self.ref.child("workshops_uploads").child("Workshop" + wshNum).child("currentlyEnrolled").setValue(commitValue)
            self.currEnrolled.text = commitValue
            self.signInOut.setTitle("Sign Out", for: .normal)
        }
        else //switches the button back
        {
            let commitValue = String(self.toInt(s: enrollSnap.value as? String)-1)
            self.ref.child("workshops_uploads").child("Workshop" + wshNum).child("currentlyEnrolled").setValue(commitValue)
            self.currEnrolled.text = commitValue
            self.signInOut.setTitle("Sign Out", for: .normal)
            self.signInOut.setTitle("Sign In", for: .normal)
        }
        
        })
       
        
 

        
}
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.speakerImg.image=finalSpeakerImage
        self.currEnrolled.text=finalEnrolledWorkshop
        self.maxEnrolled.text=finalCapacityWorkshop
        self.startTime.text=finalWorkshopTime
        self.workShopTitle.text=finalWorkshopTitle
        self.speakerName.text=finalSpeakerName
        self.workshopDescription.text=finalWorkshopDescription
        
        self.speakerImg.layer.borderWidth = 1
        self.speakerImg.layer.masksToBounds = false
        self.speakerImg.layer.borderColor = UIColor.black.cgColor
        self.speakerImg.layer.cornerRadius = speakerImg.frame.height/2
        self.speakerImg.clipsToBounds = true
        //get uid
        
        
        let wshNum = String(finalCell)
        ref=Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
      /*
        let addWS = ref?.observe(.value, with: { (snapshot) in
            if !snapshot.hasChild("EnrolledinWorkshop" + wshNum){
                
            }
            
        })*/
        let databaseHande = ref?.child("EnrolledinWorkshop" + wshNum).observe(.value, with: { (snapshot) in
            if snapshot.hasChild(uid!){
                self.signInOut.setTitle("Sign Out", for: .normal)
                
            }
         
       
    })
    

    }
}
