//
//  Users.swift
//  startUp
//
//  Created by Mladen Penev on 31.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class Users{
    
    //parameters
  private   let email:String
  private  let username:String
  private  let ticketCode:String
    
    //general init
    init(email:String, username:String, ticketCode:String) {
        
        self.email=email
        self.username=username
        self.ticketCode=ticketCode
    }
    
    
    
    //init for getting name out of users
    init(snapshot: DataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.username = snapshotValue["name"] as! String
        self.email = snapshotValue["email"] as! String
        self.ticketCode = snapshotValue["ticketCode"] as! String
        
    }
    
    
    //function to make it easy to write to firebase
    func toAnyObject() -> Any {
        return [
            "email": email,
            "username": username,
            "ticketCode": ticketCode
        ]
    }
    
    func getName()->String {
        return username
    }
    
    func getCode()->String {
        return ticketCode
    }
    
    func getEmail()->String {
        return email
    }
    
    
}


