//
//  GPMenuViewController.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 19/07/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import UIKit

class GPMenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    private var menuItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = ["Uplati parking", "Napuni račun"]
    }
    
    //MARK: Collection View Data Source
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
        
        switch indexPath.row
        {
        case 0:
            performSegueWithIdentifier("openPayment", sender: self)
        case 1:
            performSegueWithIdentifier("openAddCredit", sender: self)
        default:
            break
        }
    }
}