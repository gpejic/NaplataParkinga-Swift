//
//  GPKreiranjaKazneViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 26/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import UIKit

class GPKreiranjaKazneViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var platesTextField: UITextField!
    @IBOutlet weak var savePenalityButton: UIButton!
    @IBOutlet weak var parkingButton: UIButton!
    @IBOutlet weak var parkingPickerView: UIView!
    @IBOutlet weak var parkingPicker: UIPickerView!
    
    private var parkingPickerComponents = []
    private var selectedParking = false
    private var selectedParkingObject: GPParking?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getParkings()
        savePenalityButton.myAddCorners()
        configurePickers()
    }
    
    private func configurePickers() {
        parkingPicker.dataSource    = self
        parkingPicker.delegate      = self
    }
    
    //MARK: - UIPickerView Config
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return parkingPickerComponents.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if let parking = parkingPickerComponents[row] as? GPParking {
            return parking.parkingName
        }
        else {
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let parking = parkingPickerComponents[row] as? GPParking {
            parkingButton.setTitle(parking.parkingName, forState: UIControlState.Normal)
            selectedParkingObject = parking
            selectedParking = true
        }
    }
    
    private func getParkings() {
        parkingPickerComponents = GPCoreDataManager.sharedInstance.getParkings()
    }
    
    //MARK: - Actions
    @IBAction func savePenalityTap(sender: AnyObject) {

        if platesTextField.text.isEmpty || !selectedParking {
            showAlertWith("Greška", alertDescription: "Popunite sva polja!", forward: false)
        }
        else {
            if let parkingObject = selectedParkingObject {
                let userArray = GPCoreDataManager.sharedInstance.getUserForPlate(platesTextField.text)
                if userArray.count > 0 {
                    if let user = userArray.lastObject as? GPUser {
                       createPenality(parkingObject, user: user)
                    }
                }
                else {
                    showAlertWith("Greška", alertDescription: "Korisnik sa navedenim tablicama nije pronađen!", forward: false)
                }
            }
        }
    }
    
    private func createPenality (parking: GPParking, user: GPUser) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate, managedContext = appDelegate.managedObjectContext {
            GPCoreDataManager.sharedInstance.createParkingPenality(parking, user: user, moc: managedContext)
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
            else {
                showAlertWith("Kreirano", alertDescription: "Uspješno ste kreirali kaznu!", forward: true)
            }
        }
    }
    
    @IBAction func parkingTap(sender: AnyObject) {
        parkingPickerView.hidden    = false
    }
    
    @IBAction func parkingPickerOkTap(sender: AnyObject) {
        parkingPickerView.hidden = true
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