//
//  GPRegistrationViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 22/07/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import UIKit
import CoreData

class GPRegistrationViewController: UIViewController {
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordRepeat: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnRegistration: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureAppereance()
    }
    
    private func configureAppereance()
    {
        btnRegistration.layer.cornerRadius = 8
    }
    
    private func saveUser(username: String, password: String, email: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("GPUser", inManagedObjectContext:
            managedContext)
        
        if let user = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext) as? GPUser
        {
            user.username   = username
            user.password   = password
            user.email      = email
        }
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        else
        {
           showAlertWith("Registrovan", alertDescription: "Uspješno ste se registrovali!", forward: true)
        }
    }
    
    @IBAction func pressedRegistration(sender: AnyObject) {
       
        if txtUsername.text.isEmpty || txtPassword.text.isEmpty || txtPasswordRepeat.text.isEmpty || txtEmail.text.isEmpty
        {
            showAlertWith("Greška", alertDescription: "Popunite sva polja!", forward: false)
        }
        else if txtPassword.text != txtPasswordRepeat.text
        {
            showAlertWith("Greška", alertDescription: "Šifre se ne poklapju!", forward: false)
        }
        else
        {
            saveUser(txtUsername.text, password: txtPassword.text, email: txtEmail.text)
        }
    }
    
    private func showAlertWith(alertTitle: String, alertDescription: String, forward: Bool)
    {
        let alertVC = UIAlertController(title: alertTitle, message: alertDescription, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            if forward
            {
                self.navigationController?.popViewControllerAnimated(true)
            }
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