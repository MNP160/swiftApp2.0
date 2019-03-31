//
//  Workshop.swift
//  startUp
//
//  Created by Mladen Penev on 31.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


class Workshops{
    //data fields
    private let capacity:String
  private   let currentlyEnrolled:String
    private let time:String
  private   let speakerName:String
   private  let description:String
   private  let imagePath:String
   private let topic:String
    
    //standard enit
    init(capacity:String, enrolled:String, time:String, topic:String, name:String, image:String, desc:String){
        self.capacity=capacity
        self.currentlyEnrolled=enrolled
        self.topic=topic
        self.description=desc
        self.time=time
        self.speakerName=name
        self.imagePath=image
    }
    
    
    //custom enit-- attempting to set values directly
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.imagePath = snapshotValue["imageURL"] as! String
        self.speakerName = snapshotValue["facilitator"] as! String
        self.time = snapshotValue["time"] as! String
        self.description = snapshotValue["description"] as! String
        self.currentlyEnrolled=snapshotValue["currentlyEnrolled"] as! String
        self.topic=snapshotValue["topic"] as! String
        self.capacity=snapshotValue["capacityOfWorkshop"] as! String
    }
    //attempting to make writing easier
    func toAnyObject() -> Any {
        return [
            "currentlyEnrolled": currentlyEnrolled
            
        ]
    }
    
    //func to load image from imagePath
    func getImagefromUrl(imagePath:String)->UIImage{
        let url=URL(string:imagePath)
        let data=try? Data(contentsOf:url!)
        
        return UIImage(data: data!)!
    }
    
    func getName()->String {
        return speakerName
    }
    
    func getCapacity()->String {
        return capacity
    }
    
    func getImage()->UIImage {
        return getImagefromUrl(imagePath: imagePath)
    }
    
    func getDescription()->String {
        return description
    }
    
    func getTopic()->String {
        return topic
    }
    
    func getTime()->String {
        return time
    }
    
    func getCurEnrolled()->String {
        return currentlyEnrolled
    }
    
    func getImagePath()->String {
        return imagePath
    }
    
}
