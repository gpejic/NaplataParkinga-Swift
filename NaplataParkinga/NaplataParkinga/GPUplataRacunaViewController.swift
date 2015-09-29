//
//  GPUplataRacunaViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 16/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import UIKit

class GPUplataRacunaViewController: UIViewController {
    
    @IBOutlet weak var updateBalanceTextField: UITextField!
    @IBOutlet weak var updateBalanceButton: UIButton!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBalanceButton.myAddCorners()
    }
    
    //MARK: - Actions
    @IBAction func updateBalanceTap(sender: AnyObject) {
        if !updateBalanceTextField.text.isEmpty {
            if let value = updateBalanceTextField.text.toInt() {
                GPCoreDataManager.sharedInstance.addBalance(value)
                navigationController?.popViewControllerAnimated(true)
            }
            else {
                showAlertWith("Greška", alertDescription: "Iznos nije unesen u ispravnom formatu!", forward: false)
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