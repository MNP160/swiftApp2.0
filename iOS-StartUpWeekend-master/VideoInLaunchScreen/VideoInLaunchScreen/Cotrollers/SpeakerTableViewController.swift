//
//  SpeakerTableViewController.swift
//  
//
//  Created by Mladen Penev on 22.03.19.
//

import UIKit

class SpeakerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var speakersTable: UITableView!
    var
    
    override func viewDidLoad() {
        super.viewDidLoad()
       speakersTable.delegate=self
        speakersTable.dataSource=self
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
