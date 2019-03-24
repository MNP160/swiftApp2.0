//
//  SpeakerTableViewController.swift
//  
//
//  Created by Mladen Penev on 22.03.19.
//

import UIKit
import Firebase
import FirebaseDatabase
/*
struct Headline {
    
    var id : Int
    var title : String
    var text : String
    var image : String
    
}*/

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewController: UIImageView!
    @IBOutlet weak var titleLabelController: UILabel!
    @IBOutlet weak var contentLabelController: UILabel!
    
}

class SpeakerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var desc: String? = ""
    var titleNext: String? = ""
    var img: UIImage? = nil
    struct custSpeakerCell{
        var id:Int
        var description:String
        
    }
    
    
    
    @IBOutlet weak var speakerTbl: UITableView!
    var speakersText=[String]()
    var speakerImages = [String]()
    //var speakers = [Speakers]()
    var ref:DatabaseReference!
    var databaseHande:DatabaseHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        
        speakerTbl.delegate=self
        speakerTbl.dataSource=self
        ref=Database.database().reference()
        
        databaseHande = ref?.child("teachers_uploads").observe(.value, with: { (snapshot) in
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let imageSnap = snap.childSnapshot(forPath: "imageURL")
                //let imageURL = NSURL(string: imageSnap.value as! String)
                self.speakerImages.append(imageSnap.value as! String)
                let txtSnap = snap.childSnapshot(forPath: "description")
                self.speakersText.append(txtSnap.value as! String)
                self.speakerTbl.reloadData()
                self.speakerTbl.separatorStyle = .none
                
            }
        })
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  speakerImages.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! HeadlineTableViewCell
      
        cell.contentLabelController?.text = speakersText[indexPath.row]
        cell.titleLabelController?.text = "Tashak"
    
        let url = URL(string: speakerImages[indexPath.row])
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.imageViewController.image = UIImage(data: data!)
        cell.imageViewController.layer.borderWidth = 1
        cell.imageViewController.layer.masksToBounds = false
        cell.imageViewController.layer.borderColor = UIColor.black.cgColor
        cell.imageViewController.layer.cornerRadius = cell.imageViewController.frame.height/2
        cell.imageViewController.clipsToBounds = true
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:HeadlineTableViewCell = tableView.cellForRow(at: indexPath) as! HeadlineTableViewCell
        //let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! HeadlineTableViewCell
        let descCell = cell.contentLabelController?.text
        let titleCell = cell.titleLabelController?.text
        let imgCell = cell.imageViewController?.image
        self.desc = descCell!
        self.img = imgCell!
        self.titleNext = titleCell!
        performSegue(withIdentifier: "enlargeCell", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        var vc = segue.destination as! LargeCellViewController
        vc.finalTitle = self.titleNext!
        vc.finalImg = self.img!
        vc.finalDesc = self.desc!
    }
  
}




