//
//  GPBrisanjeParkingaViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 27/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import UIKit

class GPBrisanjeParkingaViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var parkingButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var parkingPickerView: UIView!
    @IBOutlet weak var parkingPicker: UIPickerView!
    
    private var parkingPickerComponents = []
    private var selectedParking = false
    private var selectedParkingObject: GPParking?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getParkings()
        removeButton.myAddCorners()
        configurePickers()
    }
    
    private func configurePickers() {
        parkingPicker.dataSource    = self
        parkingPicker.delegate      = self
    }
    
    private func getParkings() {
        parkingPickerComponents = GPCoreDataManager.sharedInstance.getParkings()
    }
    
    private func removeParking(parking: GPParking) {
        let success = GPCoreDataManager.sharedInstance.removeParking(parking)
        
        if success {
            showAlertWith("Izbrisan", alertDescription: "Parking je uspješno izbrisan!", forward: true)
        }
        else {
            showAlertWith("Greška", alertDescription: "Parking nije pronađen!", forward: false)
        }
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
    
    //MARK: - Actions
    @IBAction func parkingTap(sender: AnyObject) {
        parkingPickerView.hidden    = false
    }
    
    @IBAction func parkingPickerOkTap(sender: AnyObject) {
        parkingPickerView.hidden = true
    }
    
    @IBAction func removeParkingTap(sender: AnyObject) {
        if !selectedParking {
            showAlertWith("Greška", alertDescription: "Popunite sva polja!", forward: false)
        }
        else {
            if let parkingObject = selectedParkingObject {
                removeParking(parkingObject)
            }
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