//
//  largeWorkshopViewController.swift
//  startUp
//
//  Created by Mladen Penev on 24.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit

class largeWorkshopViewController: UIViewController {
    
    var finalSpeakerImage:UIImage? = nil
    var finalCapacityWorkshop = ""
    var finalEnrolledWorkshop = ""
    var finalSpeakerName = ""
    var finalWorkshopTime = ""
    var finalWorkshopTitle = ""
    var finalWorkshopDescription = ""
    
    @IBOutlet weak var speakerImg: UIImageView!
    @IBOutlet weak var maxEnrolled: UILabel!
    
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var workshopDescription: UITextView!
    
    @IBOutlet weak var currEnrolled: UILabel!
    @IBOutlet weak var workShopTitle: UILabel!
    
    @IBAction func signInBtn(_ sender: UIButton) {
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
