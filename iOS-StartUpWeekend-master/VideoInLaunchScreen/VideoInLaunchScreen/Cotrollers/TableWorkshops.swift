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
    
   
    var activityIndicatorView: UIActivityIndicatorView!
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
    var workshops=[Workshops]()
    var currWorkshop: Workshops?
        override func viewDidLoad() {
           
            
            super.viewDidLoad()
            //activity buffer
            self.tableWrkShp.backgroundView = activityIndicatorView
            activityIndicatorView.startAnimating()
            ref=Database.database().reference()
            
            tableWrkShp.dataSource=self
            tableWrkShp.delegate=self
            tableWrkShp.separatorColor=UIColor(white : 0.95, alpha:1)
            
            ref?.child("workshops_uploads").observeSingleEvent(of: .value, with: { (snapshot) in
            
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let workshop = Workshops(snapshot:snap as! DataSnapshot)
                    self.workshops.append(workshop)
                    
                    self.tableWrkShp.reloadData()
                    }
                
            })
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return workshops.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell=tableView.dequeueReusableCell(withIdentifier: "Wcell", for:indexPath) as! WorkshopTableViewCell
            
            cell.speakerName?.text = workshops[indexPath.row].getName()
            cell.workshopTime?.text = workshops[indexPath.row].getTime()
            cell.capacityWorkshop?.text = workshops[indexPath.row].getCapacity()
            cell.enrolledWorkshop?.text = workshops[indexPath.row].getCurEnrolled()
            cell.workshopTitle?.text = workshops[indexPath.row].getTopic()
            cell.currCell = indexPath.row
            
            /*
            let url = URL(string: workshopImg[indexPath.row])
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch*/
            cell.speakerImage.image = workshops[indexPath.row].getImage()
            cell.speakerImage.layer.borderWidth = 1
            cell.speakerImage.layer.masksToBounds = false
            cell.speakerImage.layer.borderColor = UIColor.black.cgColor
            cell.speakerImage.layer.cornerRadius = cell.speakerImage.frame.height/2
            cell.speakerImage.clipsToBounds = true
            
            
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
        let selectedCell = cell.currCell
        
        self.currWorkshop = Workshops(capacity: maxrCell!, enrolled: Ecell!, time: timeCell!, topic: titleCell!, name: nameCell!, image: workshops[indexPath.row].getImagePath(), desc: workshops[indexPath.row].getDescription())
        self.curDescription = workshops[indexPath.row].getDescription()
        self.curImg = wImgCell!
        self.curEnrolled = Ecell!
        self.curMax = maxrCell!
        self.curWorkTime = timeCell!
        self.curWorkTitle = titleCell!
        self.curSpeaker = nameCell!
        self.bufferCell = selectedCell
        
        
        performSegue(withIdentifier: "largeW", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "largeW" {
            var ws = segue.destination as! largeWorkshopViewController 
       
        ws.finalCell = self.bufferCell
        ws.finalWorkshop = self.currWorkshop
        }
        
    }
    
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        tableWrkShp.backgroundView = activityIndicatorView
    }
        
    }

