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
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}