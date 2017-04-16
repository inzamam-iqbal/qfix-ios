//
//  Employee.swift
//  qfix2
//
//  Created by Ismath on 4/15/17.
//  Copyright © 2017 qfix. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Employee {
    
    var ref: FIRDatabaseReference!
    var key: String?
    
    var name = String()
    var distance = String()
    var primaryNumber = String()
    var about : String?
    var dob = String()
    var catagories = [String: Bool]()
    var email = String()
    var gender = String()
    var imageUrl = String()
    var languages = [String:Bool]()
    var status : String?
    var secondaryNum : String?
    var address : String?
    
    
    init(snapShot: FIRDataSnapshot){
        self.ref = snapShot.ref
        self.key = snapShot.key
        
        self.name = (snapShot.value! as! NSDictionary)["name"] as! String
        self.catagories = (snapShot.value! as! NSDictionary)["catagary"] as! [String:Bool]
        self.languages = (snapShot.value! as! NSDictionary)["languages"] as! [String:Bool]
        self.about = (snapShot.value! as! NSDictionary)["about"] as? String
        self.dob = (snapShot.value! as! NSDictionary)["dob"] as! String
        self.primaryNumber = (snapShot.value! as! NSDictionary)["phoneNum"] as! String
        self.email = (snapShot.value! as! NSDictionary)["email"] as! String
        self.gender = (snapShot.value! as! NSDictionary)["gender"] as! String
        self.imageUrl = (snapShot.value! as! NSDictionary)["imageUrl"] as! String
        self.status = (snapShot.value! as! NSDictionary)["status"] as? String
        self.secondaryNum = (snapShot.value! as! NSDictionary)["phoneNumSecondary"] as? String
        self.address = (snapShot.value! as! NSDictionary)["address"] as? String
    }
    
    func toAnyObject() -> [String: Any]{
        return ["name": name , "gender": gender , "dob" : dob , "imageUrl" : imageUrl , "status" : status ?? " " , "catagary" : catagories , "languages" : languages , "phoneNum" : primaryNumber , "about" : about ?? " " , "email" : email, "phoneNumSecondary" : secondaryNum ?? " "]
    }
    
    func getAge() -> String{
        let currentDate = Date()
        let calander = Calendar.current
        let year = calander.component(.year, from: currentDate)
        
        let index = dob.index(dob.startIndex, offsetBy: 4)
        let birthYear = Int(dob.substring(to: index))
        
        return "Age " + String(year - birthYear!) + " years"
        
    }
    
    func toArray() -> [(String, String)]{
        let array = [("Age",self.getAge()), ("Gender", gender),("Catagories", catagoriesToStr()), ("Languages", languagesToStr()),("Secondary Number", self.secondaryNum ?? " " ),("email", self.email),("Address", self.address ?? " ")]
        return array 
    }
    
    func catagoriesToStr() -> String {
        var str = ""
        for (key,_) in self.catagories{
            str += key + "/"
        }
        return str
        
    }
    
    func languagesToStr() -> String {
        var str = ""
        for (key,_) in self.languages{
            str += key + "/"
        }
        return str
        
    }
}
