//
//  CatagoryEmployeeViewController.swift
//  qfix2
//
//  Created by Ismath on 4/11/17.
//  Copyright © 2017 qfix. All rights reserved.
//

import UIKit
import FirebaseDatabase


class CatagoryEmployeeViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{

   
    @IBOutlet weak var catagoryEmployeeTableView: UITableView!
    
    var ref:FIRDatabaseReference?
    var items = [CatagoryEmployee]()
    var catagoryName = String()
    var updated = false
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocation()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catagoryEmployeeCell", for: indexPath) as! CatagoryEmployeeTableViewCell
        
        if (items[indexPath.row].homeService ?? false){
            cell.homeServiceImage.isHidden = false
        }else{
            cell.homeServiceImage.isHidden = true
        }
        cell.nameTxt.text = items[indexPath.row].name
        cell.statusTxt.text = items[indexPath.row].status
        cell.distanceTxt.text = items[indexPath.row].distance
        cell.catagoryEmployeeCellImage.kf.setImage(with: URL(string: items[indexPath.row].imageUrl))
        cell.ageTxt.text = items[indexPath.row].getAge()

        print("item count: " + String(items.count))
        return cell
    }
    
    private func getData(center:CLLocation){
        items.removeAll()
        print("called")
        ref = FIRDatabase.database().reference()
        let geoFire = GeoFire(firebaseRef: ref?.child(Constants.Refs.LOCATION).child(catagoryName))
               
        let query = geoFire?.query(at: center, withRadius: 200)
        
        _ = query?.observe(.keyEntered, with: { (key, location) in
self.ref?.child(Constants.Refs.CATAGORYEMPLOYEE).child(key!).observe(.value, with: { (snapShot) in
            print(snapShot.key)
            let employee = CatagoryEmployee(snapShot: snapShot)
            let distance = center.distance(from: location!)
            if (distance>1000){
                employee.distance = String (format: "%.2f km away", distance/1000)
            }else{
                employee.distance = String (format: "%.2f m away", distance)
            }
            self.items.append(employee)
            self.catagoryEmployeeTableView.reloadData()
        }, withCancel: { (error) in
            print(error)
        })
            
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if (!updated){
            updated = true
            getData(center: locations[0])
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("Error getting location" + error.localizedDescription)
    }
    
    private func getLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showProfileView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showProfileView"){
            let indexPath = self.catagoryEmployeeTableView.indexPathForSelectedRow!
            
            let vc = segue.destination as! ViewProfileViewController
            
            vc.hidesBottomBarWhenPushed = true
            
            vc.navigationItem.title = catagoryName
            vc.catagory = catagoryName
            vc.employeeId = self.items[(indexPath.row)].key
            vc.distance = self.items[(indexPath.row)].distance
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
