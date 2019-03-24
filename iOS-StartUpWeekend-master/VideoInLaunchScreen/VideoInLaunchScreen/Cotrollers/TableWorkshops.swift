//
//  TableWorkshops.swift
//  startUp
//
//  Created by Mladen Penev on 24.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class TableWorkshops: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    
    @IBOutlet weak var tableWrkShp: UITableView!

    var databaseHande:DatabaseHandle?
    var ref:DatabaseReference!
        
    var workshopCap=[String]()
    var workshopCurr=[String]()
    var workshopDesc=[String]()
    var workshopTime=[String]()
    var workshopImg=[String]()
    var workshopTopic=[String]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
         ref=Database.database().reference()
            
          tableWrkShp.dataSource=self
          tableWrkShp.delegate=self
          tableWrkShp.separatorColor=UIColor(white : 0.95, alpha:1)
            
            databaseHande = ref?.child("workshops_uploads").observe(.value, with: { (snapshot) in
                
                print("main snapshot: \(snapshot)")
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                   // let workshop = Workshop(capacityOfWorkshop: "", currentlyEnrolled: "", description: "", imageURL: "", time: "", topic: "")
                    
                    
                    let imageSnap = snap.childSnapshot(forPath: "imageURL")
                    self.workshopImg.append(imageSnap.value as! String)
                   
                    let txtSnap = snap.childSnapshot(forPath: "description")
                    self.workshopDesc.append(txtSnap.value as! String)
                    //workshop.setDescription(description: txtSnap.value as! String)
                    let capacitySnap = snap.childSnapshot(forPath: "capacityOfWorkshop")
                    self.workshopCap.append(capacitySnap.value as! String)
                    let currESnap = snap.childSnapshot(forPath: "currentlyEnrolled")
                    self.workshopCurr.append(currESnap.value as! String)
                    let timeSnap = snap.childSnapshot(forPath: "time")
                    self.workshopTime.append(timeSnap.value as! String)
                    let topicSnap = snap.childSnapshot(forPath: "topic")
                    self.workshopTopic.append(topicSnap.value as! String)
                    //workshop.setCapacity(capacity: capacitySnap.value as! String)
                    //workshop.setCurEnrolled(enrolled: currESnap.value as! String)
                    //workshop.setTime(time: timeSnap.value as! String)
                    //workshop.setTopic(topic: topicSnap.value as! String)
                    /*self.workshopImg.append(imgPath)
                    self.workshopDesc.append(desc)
                    self.workshopCap.append(cap)
                    self.workshopCurr.append(currentE)
                    self.workshopTime.append(time)
                    self.workshopTopic.append(topic)*/
                    self.tableWrkShp.reloadData()
                    }

                    // self.speakerImages.append(imageSnap.value as! String)
                    //self.speakersText.append(txtSnap.value as! String)
                   //self.speakerTbl.reloadData()
                
            })
            print("GOLAM PADARAS \(workshopTopic)")
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell=tableView.dequeueReusableCell(withIdentifier: "Wcell", for:indexPath)
            cell.contentView.backgroundColor=UIColor(white : 0.95, alpha : 1)
            return cell
        }
        
    }

