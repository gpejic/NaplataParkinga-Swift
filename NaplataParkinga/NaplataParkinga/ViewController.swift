//
//  ViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 19/07/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureAppereance()
    }
    
    private func configureAppereance()
    {
        btnLogin.layer.cornerRadius = 8
    }
    
    private func myLogin()
    {
        
    }
    
    @IBAction func pressedLogout(sender: AnyObject) {
        myLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

