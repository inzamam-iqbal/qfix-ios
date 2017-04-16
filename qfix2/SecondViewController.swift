//
//  SecondViewController.swift
//  qfix2
//
//  Created by Ismath on 4/9/17.
//  Copyright © 2017 qfix. All rights reserved.
//

import UIKit
import DigitsKit

class SecondViewController: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setDigitsButtons(){
        let authenticateButton = DGTAuthenticateButton { session, error in
            if let phoneNumber = session?.phoneNumber {
                // TODO: associate the session userID with your user model
                let message = "Phone number: \(phoneNumber)"
                let alertController = UIAlertController(title: "You are logged in!", message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: .none))
                self.present(alertController, animated: true, completion: .none)
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        }
        authenticateButton?.center = self.view.center
        self.view.addSubview(authenticateButton!)

    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        
        let digits = Digits.sharedInstance()
        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        configuration?.appearance = DGTAppearance()
        configuration?.appearance.accentColor = signUpBtn.backgroundColor
        
        configuration?.phoneNumber = "+974"
        digits.authenticate(with: nil, configuration: configuration!) { (session, error) in
            if let phoneNumber = session?.phoneNumber {
                let message = "Phone number: \(phoneNumber)"
                print(message)
            } else {
                print("error Login")
            }

        }
        
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        Digits.sharedInstance().logOut()
    }
    

}

