//
//  GPMenuCell.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 21/07/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import UIKit

class GPMenuCell: UICollectionViewCell {
    
    @IBOutlet weak var lblMenuItemTitle: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
}