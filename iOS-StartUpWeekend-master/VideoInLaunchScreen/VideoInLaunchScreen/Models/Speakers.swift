//
//  Speakers.swift
//  startUp
//
//  Created by Mladen Penev on 31.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class Speakers{
    //attributes
   private let time:String
    private let description:String
   private  let name:String
   private let imagePath:String
    
    
    //standard init
    init(time:String, description:String, name:String, imagePath:String){
        self.time=time
        self.description=description
        self.name=name
        self.imagePath=imagePath
        
    }
    
    
    //attempt at reading data directly from firebase
    init(snapshot: DataSnapshot) {
       // let snapshotValue = snapshot.value as! [String: AnyObject]
        let imageSnap = snapshot.childSnapshot(forPath: "imageURL")
        self.imagePath = imageSnap.value as! String
        let nameSnap = snapshot.childSnapshot(forPath: "name")
        self.name = nameSnap.value as! String
        let timeSnap = snapshot.childSnapshot(forPath: "time")
        self.time = timeSnap.value as! String
        let descriptSnap = snapshot.childSnapshot(forPath: "description")
        self.description = descriptSnap.value as! String
    }
    
    //function to attempt to load image from imagePAth
    
    
    func getSpeakerImage(imagePath:String)->UIImage{
        let url=URL(string:imagePath)
        let data=try? Data(contentsOf:url!)
        
        return UIImage(data: data!)!
    }
    
    func getName()->String {
        return name
    }
    
    func getTime()->String {
        return time
    }
    
    func getDescription()->String {
        return description
    }
    
    func getImage()->UIImage {
        return getSpeakerImage(imagePath: imagePath)
    }
    func getImagePath()->String{
        return imagePath
    }
    
    
}
