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
    
    private func checkTextFields()
    {
        if txtUsername.text.isEmpty || txtPassword.text.isEmpty
        {
            showAlertWith("Greška", alertDescription: "Popunite sva polja!")
        }
        else
        {
           myLogin()
        }
    }
    
    private func myLogin()
    {
        //showAlertWith("Greška", alertDescription: "Korisnik nije pronađen!")
        performSegueWithIdentifier("openMenu", sender: self)
    }
    
    @IBAction func pressedLogout(sender: AnyObject) {
        checkTextFields()
    }
    
    private func showAlertWith(alertTitle: String, alertDescription: String)
    {
        let alertVC = UIAlertController(title: alertTitle, message: alertDescription, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        
        alertVC.addAction(OKAction)
        
        presentViewController(alertVC, animated: true) {
            // ...
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}