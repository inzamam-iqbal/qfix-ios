//
//  CatagoryEmployee.swift
//  qfix2
//
//  Created by Ismath on 4/13/17.
//  Copyright © 2017 qfix. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CatagoryEmployee{
    var name: String!
    var gender: String!
    var dob: String!
    var imageUrl: String!
    var distance: String!
    var status: String!
    var homeService: Bool!
    var updateTime: Double!
    var ref: FIRDatabaseReference!
    var key: String?
    
    init(snapShot: FIRDataSnapshot){
        
        self.ref = snapShot.ref
        self.key = snapShot.key
        self.name = (snapShot.value! as! NSDictionary)["name"] as! String
        self.gender = (snapShot.value! as! NSDictionary)["gender"] as? String
        self.dob = (snapShot.value! as! NSDictionary)["dob"] as! String
        self.imageUrl = (snapShot.value! as! NSDictionary)["imageUrl"] as? String
        self.status = (snapShot.value! as! NSDictionary)["status"] as! String
        self.homeService = (snapShot.value! as! NSDictionary)["homeService"] as? Bool
        self.updateTime = (snapShot.value! as! NSDictionary)["updateTime"] as! Double
    }
    
    
    func toAnyObject() -> [String: Any]{
        return ["name": name , "gender": gender , "dob" : dob , "imageUrl" : imageUrl , "status" : status , "homeService" : homeService , "updateTime" : updateTime]
    }
    
    func getAge() -> String{
        let currentDate = Date()
        let calander = Calendar.current
        let year = calander.component(.year, from: currentDate)
        
        let index = dob.index(dob.startIndex, offsetBy: 4)
        let birthYear = Int(dob.substring(to: index))
        
        return "Age " + String(year - birthYear!) + " years"
        
    }
}
