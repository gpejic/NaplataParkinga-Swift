//
//  UIButton+Helpers.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 05/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func myAddCorners(radius: CGFloat = 8) {
        self.layer.cornerRadius = radius
    }
}