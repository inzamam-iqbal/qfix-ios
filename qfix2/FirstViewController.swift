//
//  FirstViewController.swift
//  qfix2
//
//  Created by Ismath on 4/9/17.
//  Copyright © 2017 qfix. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Kingfisher

class FirstViewController: UIViewController
{
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ref:FIRDatabaseReference?
    var items = [Catagory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        ref?.child(Constants.Refs.CATAGORY).observe(.value, with: { (snapShot) in
            print(snapShot.children.allObjects.count)
            for catagory in snapShot.children.allObjects {
                let catagory = Catagory(snapShot: catagory as! FIRDataSnapshot)
                if (catagory.name != "Taxi-Car" && catagory.name != "Taxi-Van"){
                    self.items.append(catagory)
                    self.collectionView.reloadData()
                }
                
            }
        }, withCancel: { (error) in
            print(error)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatagoryViewCell
        cell.awakeFromNib()
        cell.name.text = items[indexPath.row].name
        cell.image.kf.setImage(with: URL(string: items[indexPath.row].image!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 30 - 2 * collectionViewFlowLayout.sectionInset.left - 4 * collectionViewFlowLayout.minimumInteritemSpacing)/3;
        return CGSize(width: size  , height: size)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCatagoryEmployees", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showCatagoryEmployees"){
            let indexPaths = self.collectionView.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destination as! CatagoryEmployeeViewController
            
            vc.navigationItem.title = self.items[indexPath.row].name
            vc.catagoryName = self.items[indexPath.row].name
            
        }
    }
    
}

