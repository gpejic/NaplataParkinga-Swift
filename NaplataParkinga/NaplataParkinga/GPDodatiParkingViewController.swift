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
    
    @IBOutlet weak var newParkingTextField: UITextField!
    @IBOutlet weak var addParkingButton: UIButton!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addParkingButton.myAddCorners()
    }
    
    //MARK: - Actions
    @IBAction func updateBalanceTap(sender: AnyObject) {
        if !newParkingTextField.text.isEmpty {
            if let value = newParkingTextField.text.toInt() {
                GPCoreDataManager.sharedInstance.addToBalance(value)
                navigationController?.popViewControllerAnimated(true)
            }
        }
    }
}