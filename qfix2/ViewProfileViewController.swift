//
//  ViewProfileViewController.swift
//  qfix2
//
//  Created by Ismath on 4/15/17.
//  Copyright © 2017 qfix. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Kingfisher
import MessageUI

class ViewProfileViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var catgoryNameTxtBig: UILabel!
    @IBOutlet weak var nameSmallTxt: UILabel!
    @IBOutlet weak var distanceTxt: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var smsBtn: UIButton!
    @IBOutlet weak var aboutTxt: UILabel!
    @IBOutlet weak var tableView: UITableView!

    
    var catagory = String()
    var employeeId : String!
    var employee:Employee!
    var distance :String!
    var tableViewData = [(String,String)]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2.0
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 1.5
        profileImage.layer.borderColor = nameTxt.textColor.cgColor
        print(profileImage.frame.size.height)
        print(profileImage.frame.size.width)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getData(){
        let ref = FIRDatabase.database().reference()
        
        ref.child(Constants.Refs.EMPLOYEES).child(self.employeeId).observe(.value, with: { (snapShot) in
            print(self.employeeId)
            self.employee = Employee(snapShot: snapShot)
            self.tableViewData = self.employee.toArray()
            self.tableView.reloadData()
            self.setUIElements()
        }, withCancel: { (error) in
            print(error)
        })
    }
    
    func setUIElements(){
        profileImage.kf.setImage(with: URL(string: employee.imageUrl))
        nameTxt.text = employee.name
        catgoryNameTxtBig.text = catagory
        nameSmallTxt.text = employee.name
        aboutTxt.text = employee.about ?? " "
        distanceTxt.text = distance
    }
    
    @IBAction func callBtnPressed(_ sender: UIButton) {
        let startIndex = employeeId.index(employeeId.startIndex, offsetBy: 1)
        
        if let url = URL(string: "tel:\(self.employeeId.substring(from: startIndex))"),UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func smsBtnPressed(_ sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()){
            let controller = MFMessageComposeViewController()
            controller.body = "Sent through Qfix \n"
            controller.recipients = [employeeId]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

}


extension ViewProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewProfileCell", for: indexPath) as! vieWProfileTableViewCell
        
        cell.typeTxt.text = tableViewData[indexPath.row].0
        cell.valueTxt.text = tableViewData[indexPath.row].1
        
        if (indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor.white
        }else{
            cell.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha:1)
        }
        
        return cell
    }

}
