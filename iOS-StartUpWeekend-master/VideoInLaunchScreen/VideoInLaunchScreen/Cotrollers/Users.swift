//
//  Users.swift
//  startUp
//
//  Created by Mladen Penev on 23.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation


class Users{
    
    private var name:String
    private var email:String
    private  var key:String
    private var ticketCode:String
   

    
    init(name:String, email:String, key:String, ticketCode:String){
        self.name=name
        self.email=email
        self.key=key
        self.ticketCode=ticketCode
    }
    
    func getName() -> String {
        return name
    }
    func getKey() -> String {
        return key
    }
    func getEmail() -> String {
        return email
    }
    func getTicketCode() -> String {
        return ticketCode
    }
    
    
    
    func setName(name:String)->Void{
        self.name=name
        
    }
    
    func setKey(key:String)->Void{
        self.key=key
        
    }
    func setEmail(email:String)->Void{
        self.email=email
        
    }
    func setTicketCode(ticketCode:String)->Void{
        self.ticketCode=ticketCode
        
    }
  
}
