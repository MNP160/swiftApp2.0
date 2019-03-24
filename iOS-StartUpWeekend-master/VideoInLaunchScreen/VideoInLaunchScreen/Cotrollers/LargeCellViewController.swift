//
//  LargeCellViewController.swift
//  startUp
//
//  Created by Mladen Penev on 24.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit


class LargeCellViewController: UIViewController {

    var finalTitle = ""
    var finalDesc = ""
    var finalImg: UIImage? = nil

    @IBOutlet weak var speakerDesc: UITextView!
    @IBOutlet weak var speakerImg: UIImageView!
    @IBOutlet weak var newTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newTitle.text = finalTitle
        self.speakerImg.image = finalImg
        self.speakerDesc.text = finalDesc
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
