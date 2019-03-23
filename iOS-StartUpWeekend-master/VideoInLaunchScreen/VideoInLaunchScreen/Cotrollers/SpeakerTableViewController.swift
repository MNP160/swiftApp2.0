//
//  SpeakerTableViewController.swift
//  
//
//  Created by Mladen Penev on 22.03.19.
//

import UIKit
import Firebase
import FirebaseDatabase
class SpeakerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
   
    @IBOutlet weak var speakerTbl: UITableView!
    var speakersText=[String]()
    var speakerImages = [String]()
    //var speakers = [Speakers]()
    var ref:DatabaseReference!
    var databaseHande:DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speakerTbl.delegate=self
        speakerTbl.dataSource=self
        ref=Database.database().reference()
        
        databaseHande = ref?.child("teachers_uploads").observe(.value, with: { (snapshot) in
        //let ref = self.ref!.child("teachers_uploads")
        //ref.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let imageSnap = snap.childSnapshot(forPath: "imageURL")
                self.speakerImages.append(imageSnap.value as! String)
                let txtSnap = snap.childSnapshot(forPath: "description")
                self.speakersText.append(txtSnap.value as! String)
                self.speakerTbl.reloadData()
            }
        })
        
    }
       
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  speakerImages.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) //as! UITableViewCell
      
        cell.textLabel?.text = speakersText[indexPath.row]
        
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }

}

