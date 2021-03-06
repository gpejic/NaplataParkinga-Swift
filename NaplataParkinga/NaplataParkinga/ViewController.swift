//
//  ViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 19/07/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var debugOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureAppereance()
    }
    
    private func configureAppereance() {
        navigationItem.setHidesBackButton(true, animated: false)
        btnLogin.myAddCorners()
    }
    
    private func checkTextFields() {
        if txtUsername.text.isEmpty || txtPassword.text.isEmpty {
            showAlertWith("Greška", alertDescription: "Popunite sva polja!")
        }
        else {
           myLogin()
        }
    }
    
    private func myLogin() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"User")
        fetchRequest.predicate = NSPredicate(format:"username == %@ AND password == %@", txtUsername.text, txtPassword.text)
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            if results.count == 0 {
                showAlertWith("Greška", alertDescription: "Korisnik nije pronađen!")
            }
            else {
                
                let currentUser = results.first as! GPUser
                currentUser.isCurrentUser = true
                
                if !managedContext.save(&error) {
                    println("Could not save \(error), \(error?.userInfo)")
                }
                else {
                    performSegueWithIdentifier("openMenu", sender: self)
                }
            }
        }
        else {
            println("Could not fetch \(error), \(error!.userInfo)")
            showAlertWith("Greška", alertDescription: "Korisnik nije pronađen!")
        }
    }
    
    @IBAction func pressedLogout(sender: AnyObject) {
        if debugOn {
            performSegueWithIdentifier("openMenu", sender: self)
        }
        else {
            checkTextFields()
        }
    }
    
    private func showAlertWith(alertTitle: String, alertDescription: String) {
        let alertVC = UIAlertController(title: alertTitle, message: alertDescription, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        
        alertVC.addAction(OKAction)
        
        presentViewController(alertVC, animated: true) {
            // ...
        }
    }
}