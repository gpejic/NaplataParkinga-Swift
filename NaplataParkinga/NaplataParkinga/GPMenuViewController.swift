//
//  GPMenuViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 19/07/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import UIKit

enum UserTypes: Int {
    case Normal = 0
    case Controller = 1
    case Admin = 2
}

class GPMenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    private var menuItems       = [String]()
    private var currentUserType = UserTypes.Normal
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "LOGOUT", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logoutUser:")), animated: false)
        setupUserSpecifics()
    }
    
    //MARK: Helpers
    private func setupUserSpecifics()
    {
        let currentUser = GPCoreDataManager.sharedInstance.getCurrentUser()
        if let type = UserTypes(rawValue: currentUser.userType.integerValue) {
            currentUserType = type
        }
        
        switch currentUserType {
        case .Normal:
            menuItems = ["Uplatiti parking", "Napuniti račun"]
        case .Controller:
            menuItems = ["Naplatiti kaznu"]
        case .Admin:
            menuItems = ["Dodati sadržaj", "Ažurirati sadržaj", "Obrisati saržaj"]
        default:
            break
        }
    }
    
    func logoutUser(sender: UIBarButtonItem) {
        println("USER LOGGED OUT")
        GPCoreDataManager.sharedInstance.logoutCurrentUser()
        performSegueWithIdentifier("BackToLogin", sender: self)
    }
    
    //MARK: - Collection View Data Source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return menuItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GPMenuCell", forIndexPath: indexPath) as! GPMenuCell
        
        cell.lblMenuItemTitle.text = menuItems[indexPath.row]
        
        return cell
    }
    
    //MARK: Collection View Delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch currentUserType {
        case .Normal:
            switch indexPath.row {
            case 0:
                performSegueWithIdentifier("openPayment", sender: self)
            case 1:
                performSegueWithIdentifier("openAddCredit", sender: self)
            default:
                break
            }
        case .Controller:
            performSegueWithIdentifier("showPenality", sender: self)
        case .Admin:
            break
        default:
            break
        }
        
    }
}