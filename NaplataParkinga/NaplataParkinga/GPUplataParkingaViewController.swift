//
//  GPUplataParkingaViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 05/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import UIKit

class GPUplataParkingaViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var parkingButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var plateTextField: UITextField!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var parkingPickerView: UIView!
    @IBOutlet weak var parkingPicker: UIPickerView!
    @IBOutlet weak var timePickerView: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    private var parkingPickerComponents = []
    
    private var selectedParking = false
    private var selectedTime    = false
    
    private var selectedParkingObject: GPParking?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getParkings()
        payButton.myAddCorners()
        configurePickers()
    }
    
    private func configurePickers() {
        parkingPicker.dataSource    = self
        parkingPicker.delegate      = self
    }
    
    private func getParkings() {
       parkingPickerComponents = GPCoreDataManager.sharedInstance.getParkings()
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
    
    private func saveParking(plate: String, parking: GPParking, parkingTime: Double)
    {
       if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate, managedContext = appDelegate.managedObjectContext {
            GPCoreDataManager.sharedInstance.createParkingTicket(parking, plate: plate, duration: parkingTime, moc: managedContext)
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
            else {
                showAlertWith("Uplaćeno", alertDescription: "Uspješno ste uplatili parking!", forward: true)
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func parkingTap(sender: AnyObject) {
        timePickerView.hidden       = true
        parkingPickerView.hidden    = false
    }
    
    @IBAction func timeTap(sender: AnyObject) {
        parkingPickerView.hidden    = true
        timePickerView.hidden       = false
    }
    
    @IBAction func payTap(sender: AnyObject) {
        
        if plateTextField.text.isEmpty || !selectedParking || !selectedTime {
            showAlertWith("Greška", alertDescription: "Popunite sva polja!", forward: false)
        }
        else {
            if let parkingObject = selectedParkingObject {
                let timeInMinutes = myRoundNumber(Double(timePicker.countDownDuration / 60.0), numberOfPlaces: 0.0)
                let currentUser = GPCoreDataManager.sharedInstance.getCurrentUser()
                let price = (timeInMinutes/60.0) * parkingObject.price.doubleValue
                if currentUser.balance.doubleValue >= price {
                    currentUser.balance = NSNumber(double: currentUser.balance.doubleValue - price)
                    saveParking(plateTextField.text, parking: parkingObject, parkingTime: timeInMinutes)
                }
                else {
                    showAlertWith("Greška", alertDescription: "Nemate dovoljno kredita na računu!", forward: false)
                }
            }
        }
    }
    
    @IBAction func parkingPickerOkTap(sender: AnyObject) {
        parkingPickerView.hidden = true
    }
    
    @IBAction func timePickerOkTap(sender: AnyObject) {
        timePickerView.hidden = true
        let timeInMinutes = myRoundNumber(Double(timePicker.countDownDuration / 60.0), numberOfPlaces: 0.0)
        timeButton.setTitle("\(timeInMinutes) min", forState: UIControlState.Normal)
        selectedTime = true
    }
    @IBAction func datePickerAction(sender: AnyObject) {
        
    }
    
    private func myRoundNumber(num: Double, numberOfPlaces: Double) -> Double {
        let multiplier = pow(10.0, numberOfPlaces)
        let rounded = round(num * multiplier) / multiplier
        return rounded
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