//
//  WorkshopTable.swift
//  
//
//  Created by Mladen Penev on 24.03.19.
//

import UIKit

class WorkshopTable: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var workshopsTable: WorkshopTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workshopsTable.dataSource=self
        workshopsTable.delegate=self
        
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
