//
//  RegController.swift
//  startUp
//
//  Created by Mladen Penev on 10.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class checkBox:UIButton{
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setTitle("Accepted", for: UIControl.State.normal)
            } else {
                self.setTitle("NotAccepted", for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    
}



func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

class RegController: UIViewController {
    
    @IBOutlet weak var tapLabel: UILabel!
    
    @IBOutlet weak var registerLabel: UILabel!
   
    @IBOutlet weak var acceptBtn: checkBox!
    
    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passTxt: UITextField! //ticket number
    
    var ref:DatabaseReference!
    var databaseHande:DatabaseHandle?
    var isVerified = false
    
    func verifyInput(username: String, email:String, password:String) -> Bool{
        
        ref=Database.database().reference()
        ref?.child("Keys").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
       // databaseHande = ref?.child("Keys").observe(.value, with: { (snapshot) in
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let imageSnap = snap.childSnapshot(forPath: "key")
                if  (password.count == 6 && password == imageSnap.value as? String && username.count != 0 && isValidEmail(testStr: email)){
                    self.isVerified = true
                    break
                }
                else{
                    self.isVerified = false
                    
                }
            }
            
        })
        return isVerified
    }
    
    @IBAction func registerClick(_ sender: UIButton) {
        
        ref=Database.database().reference()
        
        let username=userNameTxt.text
        let password = passTxt.text
        
        
        ref.queryOrdered(byChild: "Keys").queryEqual(toValue: self.passTxt.text).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            
            
            
            if (username!.count != 0 && isValidEmail(testStr: self.emailTxt.text!))
                {
                    Auth.auth().createUser(withEmail:self.emailTxt.text!,password:self.passTxt.text!,completion:{(user,error) in
                        
                        if user != nil{
                            //success
                            
                            self.performSegue(withIdentifier: "loginSuccess", sender: self)
                        }
                            
                        else{
                            //fail
                            
                            let alertController = UIAlertController(title: "Registration Failed", message:
                                "Please Input Data Correctly", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                            
                            self.present(alertController, animated: true, completion: nil)
                            
                            
                        }
                        
                    })
                    
                    print("wtf is going on TRUE")
               
                }
                else{
                    
                       print("wtf is going on FALSE")
                }
        
          
         
            
        })

   /*
        let test = verifyInput(username: username!, email: email!, password: password!)
        print("Tova e dobro\(test)")
        if test && acceptBtn.isChecked{
            Auth.auth().createUser(withEmail:email!,password:password!,completion:{(user,error) in
                
                if user != nil{
                    //success
                    
                    self.performSegue(withIdentifier: "loginSuccess", sender: self)
                }
                    
                else{
                    //fail
                   
                    let alertController = UIAlertController(title: "Registration Failed", message:
                        "Please Input Data Correctly", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    
                        self.present(alertController, animated: true, completion: nil)
                    
                    
                }
                
            })
        } */

        
    
    }
   
    
    @IBAction func showTerms(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "terms")
        self.addChild(popOverVC)
      
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        self.showAnimate()
    }
    /*
    @IBAction func closeTerms(_ sender: UIButton) {
        self.removeAnimate()
    }
    */
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    /*
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.registerLabel.text? = "Wow, this shit works"
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
            } else {
                self.registerLabel.text? = "Please register we pedal"
            }
        }
    }
    
    
    

}
