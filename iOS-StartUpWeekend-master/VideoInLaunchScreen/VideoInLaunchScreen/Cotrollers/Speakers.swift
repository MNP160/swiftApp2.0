//
//  Speakers.swift
//  startUp
//
//  Created by Mladen Penev on 23.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import FirebaseDatabase





public class Speakers{
   // private var name:String
    private var imageURL:String
   // private  var key:String
    private var description:String
   // private var time:String
   // private var position:Int
    
  
    
   // init(name:String, imageURL:String, key:String,description:String, time:String,position:Int){
        
    //    self.name=name
    //    self.description=description
     //   self.imageURL=imageURL
     //   self.key=key
     //   self.time=time
      //  self.position=position
        
   // }
    init(description:String, imageURL:String){
        self.description=description
        self.imageURL=imageURL
    }
    
  //  func getName() -> String {
   //     return name
   // }
 //   func getKey() -> String {
   //     return key
   // }
    func getImageURL() -> String {
        return imageURL
    }
 //   func getTime() -> String {
   //     return time
  //  }
    func getDescription() -> String {
        return description
    }
   // func getPosition() -> Int {
    //    return position
  //  }
    
    
    //func setName(name:String)->Void{
     //   self.name=name
        
   // }
    
   // func setKey(key:String)->Void{
      //  self.key=key
        
   // }
  //  func setTime(time:String)->Void{
    //    self.time=time
        
   // }
    func setDescription(description:String)->Void{
        self.description=description
        
    }
    func setImageURL(imageURL:String)->Void{
        self.imageURL=imageURL
        
    }
    //func setPosition(position:Int)->Void{
      //  self.position=position
        
   // }
    
}
