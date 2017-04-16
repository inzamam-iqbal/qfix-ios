//
//  CatagoryModel.swift
//  qfix2
//
//  Created by Ismath on 4/10/17.
//  Copyright © 2017 qfix. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class Catagory{
    var name: String!
    var image: String?
    var ref: FIRDatabaseReference!
    var key: String?
    
    init(snapShot: FIRDataSnapshot){
        
        self.ref = snapShot.ref
        self.key = snapShot.key
        self.name = (snapShot.value! as! NSDictionary)["name"] as! String
        self.image = (snapShot.value! as! NSDictionary)["image"] as? String
    }
    
    init (name: String, image: String){
        self.name = name
        self.image = image
    }
    
    func toAnyObject() -> [String: Any]{
        return ["name": name , "image": image ?? ""]
    }
}
