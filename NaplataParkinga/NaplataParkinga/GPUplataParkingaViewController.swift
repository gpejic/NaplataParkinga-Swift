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
    
    let parkingPickerComponents = ["Stupine", "Bulevar", "Fakultet Elektrotehnike", "Korzo", "Panonska jezera"]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payButton.myAddCorners()
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
        return parkingPickerComponents[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        parkingButton.setTitle(parkingPickerComponents[row], forState: UIControlState.Normal)
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
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func parkingPickerOkTap(sender: AnyObject) {
        parkingPickerView.hidden = true
    }
    
    @IBAction func timePickerOkTap(sender: AnyObject) {
        timePickerView.hidden = true
        println("Duration: \(timePicker.countDownDuration)")
    }
    @IBAction func datePickerAction(sender: AnyObject) {
        
    }
}