//
//  GPMenuViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 19/07/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import UIKit

enum UserTypes {
    case Normal
    case Controller
    case Admin
}

class GPMenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    private var menuItems       = [String]()
    private var currentUserType = UserTypes.Normal
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUserSpecifics()
    }
    
    //MARK: Helpers
    private func setupUserSpecifics()
    {
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
        
        switch indexPath.row {
        case 0:
            performSegueWithIdentifier("openPayment", sender: self)
        case 1:
            performSegueWithIdentifier("openAddCredit", sender: self)
        default:
            break
        }
    }
}