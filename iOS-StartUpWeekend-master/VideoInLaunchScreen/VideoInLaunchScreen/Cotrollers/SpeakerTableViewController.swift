//
//  SpeakerTableViewController.swift
//  
//
//  Created by Mladen Penev on 22.03.19.
//

import UIKit
import Firebase
import FirebaseDatabase


class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewController: UIImageView!
    @IBOutlet weak var titleLabelController: UILabel!
    @IBOutlet weak var contentLabelController: UILabel!
   
    
}

class SpeakerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activityIndicatorView: UIActivityIndicatorView!
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
    var speakerNames = [String]()
    var speakers = [Speakers]()
    var ref:DatabaseReference!
    var databaseHande:DatabaseHandle?
    var speaker: Speakers?
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.speakerTbl.separatorStyle = .none
        speakerTbl.delegate=self
        speakerTbl.dataSource=self
        
        ref=Database.database().reference()
        databaseHande = ref?.child("teachers_uploads").observe(.value, with: { (snapshot) in
            
            for child in snapshot.children {
                self.speaker=Speakers(snapshot: child as! DataSnapshot)
                self.speakers.append(self.speaker!)
                self.speakerTbl.reloadData()
            }
        })
        
        
    }

    
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        
        speakerTbl.backgroundView = activityIndicatorView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.speakerTbl.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }

        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  speakers.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! HeadlineTableViewCell
      
        cell.contentLabelController?.text = speakers[indexPath.row].getDescription()
        cell.titleLabelController?.text = speakers[indexPath.row].getName()
    
    /*    let url = URL(string: speakerImages[indexPath.row])
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch */
        cell.imageViewController.image = speakers[indexPath.row].getImage()
        cell.imageViewController.layer.borderWidth = 1
        cell.imageViewController.layer.masksToBounds = false
        cell.imageViewController.layer.borderColor = UIColor.black.cgColor
        cell.imageViewController.layer.cornerRadius = cell.imageViewController.frame.height/2
        cell.imageViewController.clipsToBounds = true
        // if indexpath.row = speakerImages.count   self.activityIndicatorView.stopAnimating()
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
        if segue.identifier == "enlargeCell" {
        var vc = segue.destination as! LargeCellViewController
        vc.finalTitle = self.titleNext!
        vc.finalImg = self.img!
        vc.finalDesc = self.desc!
    }
  
}


}

