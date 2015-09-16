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
        navigationController?.popViewControllerAnimated(true)
    }
}