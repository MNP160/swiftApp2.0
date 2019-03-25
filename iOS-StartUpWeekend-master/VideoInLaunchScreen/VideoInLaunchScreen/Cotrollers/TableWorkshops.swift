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

class WorkshopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var capacityWorkshop: UILabel!
    @IBOutlet weak var enrolledWorkshop: UILabel!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var workshopTime: UILabel!
    @IBOutlet weak var workshopTitle: UILabel!
    var currCell: Int = -1
    
}
class TableWorkshops: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   

    var curImg:UIImage? = nil
    var curSpeaker: String? = ""
    var curWorkTitle: String? = ""
    var curWorkTime: String? = ""
    var curEnrolled: String? = ""
    var curMax: String? = ""
    var curDescription: String? = ""
    var bufferCell: Int = -1
    
    @IBOutlet weak var tableWrkShp: UITableView!

    var databaseHande:DatabaseHandle?
    var ref:DatabaseReference!
        
    var workshopCap=[String]()
    var workshopCurr=[String]()
    var workshopDesc=[String]()
    var workshopStartTime=[String]()
    var workshopImg=[String]()
    var workshopTopic=[String]()
    var workshopSpeaker = [String]()
    
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
                    let speakerSnap = snap.childSnapshot(forPath: "facilitator")
                    self.workshopSpeaker.append(speakerSnap.value as! String)
                    let txtSnap = snap.childSnapshot(forPath: "description")
                    self.workshopDesc.append(txtSnap.value as! String)
                    //workshop.setDescription(description: txtSnap.value as! String)
                    let capacitySnap = snap.childSnapshot(forPath: "capacityOfWorkshop")
                    self.workshopCap.append(capacitySnap.value as! String)
                    let currESnap = snap.childSnapshot(forPath: "currentlyEnrolled")
                    self.workshopCurr.append(currESnap.value as! String)
                    let timeSnap = snap.childSnapshot(forPath: "time")
                    self.workshopStartTime.append(timeSnap.value as! String)
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
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return workshopTopic.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell=tableView.dequeueReusableCell(withIdentifier: "Wcell", for:indexPath) as! WorkshopTableViewCell
            
            cell.speakerName?.text = workshopSpeaker[indexPath.row]
            cell.workshopTime?.text = workshopStartTime[indexPath.row]
            cell.capacityWorkshop?.text = workshopCap[indexPath.row]
            cell.enrolledWorkshop?.text = workshopCurr[indexPath.row]
            cell.workshopTitle?.text = workshopTopic[indexPath.row]
            bufferCell = indexPath.row
            
            
            let url = URL(string: workshopImg[indexPath.row])
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cell.speakerImage.image = UIImage(data: data!)
            cell.speakerImage.layer.borderWidth = 1
            cell.speakerImage.layer.masksToBounds = false
            cell.speakerImage.layer.borderColor = UIColor.black.cgColor
            cell.speakerImage.layer.cornerRadius = cell.speakerImage.frame.height/2
            cell.speakerImage.clipsToBounds = true
            cell.currCell = bufferCell
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:WorkshopTableViewCell = tableView.cellForRow(at: indexPath) as! WorkshopTableViewCell
        let nameCell=cell.speakerName?.text
        let titleCell=cell.workshopTitle?.text
        let timeCell=cell.workshopTime?.text
        let Ecell=cell.enrolledWorkshop?.text
        let maxrCell=cell.capacityWorkshop?.text
        let wImgCell=cell.speakerImage?.image
        
        self.curDescription = workshopDesc[indexPath.row]
        self.curImg=wImgCell!
        self.curEnrolled=Ecell!
        self.curMax=maxrCell!
        self.curWorkTime=timeCell!
        self.curWorkTitle=titleCell!
        self.curSpeaker=nameCell!
        
        performSegue(withIdentifier: "largeW", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "largeW" {
        var ws = segue.destination as! largeWorkshopViewController
        ws.finalCapacityWorkshop=self.curMax!
        ws.finalSpeakerName=self.curSpeaker!
        ws.finalWorkshopTitle=self.curWorkTitle!
        ws.finalWorkshopTime=self.curWorkTime!
        ws.finalEnrolledWorkshop=self.curEnrolled!
        ws.finalSpeakerImage=self.curImg!
        ws.finalWorkshopDescription=self.curDescription!
        ws.finalCell = self.bufferCell
        }
        
    }
        
    }

