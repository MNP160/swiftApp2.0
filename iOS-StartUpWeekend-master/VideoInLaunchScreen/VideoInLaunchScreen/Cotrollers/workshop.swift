//
//  workshop.swift
//  startUp
//
//  Created by Mladen Penev on 24.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import UIKit

class Workshop{
    
    private var capacityOfWorkshop:String
    private var currentlyEnrolled:String
    private  var description:String
    private var imageURL:String
    private var time:String
    private var topic:String
    
    
    
    init(capacityOfWorkshop:String, currentlyEnrolled:String, description:String, imageURL:String, time:String, topic:String){
        self.capacityOfWorkshop=capacityOfWorkshop
        self.currentlyEnrolled=currentlyEnrolled
        self.time=time
        self.topic=topic
        self.imageURL=imageURL
        self.description=description
    }
    
    func getCapacity() -> String {
        return capacityOfWorkshop
    }
    func getCurEnrolled() -> String {
        return currentlyEnrolled
    }
    func getDescription() -> String {
        return description
    }
    func getImageURL() -> String {
        return imageURL
    }
    
    func getTime()->String{
        return time
    }
    func getTopic()->String{
        return topic
    }
    
    
    
    func setCapacity(capacity:String)->Void{
        self.capacityOfWorkshop=capacity
        
    }
    
    func setCurEnrolled(enrolled:String)->Void{
        self.currentlyEnrolled=enrolled
        
    }
    func setDescription(description:String)->Void{
        self.description=description
        
    }
    func setTime(time:String)->Void{
        self.time=time
        
    }
    
    func setImageURL(image:String)->Void{
        self.imageURL=image
    }
    
    func setTopic(topic:String)->Void{
        self.topic=topic
    }
    
    
}
