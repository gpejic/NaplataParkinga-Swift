//
//  GPDodatiParkingViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 27/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import UIKit

class GPDodatiParkingViewController: UIViewController {
    
    @IBOutlet weak var newParkingNameTextField: UITextField!
    @IBOutlet weak var newParkingPriceTextField: UITextField!
    @IBOutlet weak var addParkingButton: UIButton!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addParkingButton.myAddCorners()
    }
    
    private func createNewParking(parkingName: String, parkingPrice: NSNumber) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate, managedContext = appDelegate.managedObjectContext {
            let parkingDictionary = NSDictionary(dictionary: ["parkingName" : parkingName, "price" : parkingPrice])
            GPCoreDataManager.sharedInstance.createNewParking(parkingDictionary, moc: managedContext)
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
            else {
                showAlertWith("Kreirano", alertDescription: "Uspješno ste kreirali novi parking!", forward: true)
            }
        }
    }

    
    //MARK: - Actions
    @IBAction func addNewParkingTap(sender: AnyObject) {
        if !newParkingNameTextField.text.isEmpty || !newParkingPriceTextField.text.isEmpty {
            if let price = newParkingPriceTextField.text.toInt() {
                createNewParking(newParkingNameTextField.text, parkingPrice: NSNumber(integer: price))
            }
            else {
                showAlertWith("Greška", alertDescription: "Cijena mora biti broj!", forward: false)
            }
        }
        else {
            showAlertWith("Greška", alertDescription: "Popunite sva polja!", forward: false)
        }
    }
    
    private func showAlertWith(alertTitle: String, alertDescription: String, forward: Bool) {
        let alertVC = UIAlertController(title: alertTitle, message: alertDescription, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            if forward {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
        alertVC.addAction(OKAction)
        
        presentViewController(alertVC, animated: true) {
            // ...
        }
    }

}