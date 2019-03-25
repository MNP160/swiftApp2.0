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
    
    var ref:DatabaseReference!
    var databaseHande:DatabaseHandle?
    
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
        
        if self.signInOut.titleLabel?.text == "Sign In"{
        let wshNum = String(finalCell+1)
        databaseHande = ref?.child("EnrolledinWorkshop" + wshNum).observe(.value, with: { (snapshot) in
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                
                
                
            }
        })
            print("EnrolledinWorkshop" + wshNum)
            self.signInOut.setTitle("Sign Out", for: .normal)
        }
        else
        {
        print("povervah")
        }
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
        
        databaseHande = ref?.child("EnrolledinWorkshop" + wshNum).observe(.value, with: { (snapshot) in
            if snapshot.hasChild(uid!){
                self.signInOut.setTitle("Sign Out", for: .normal)
                
            }
            
       
    })
    

    }
}
