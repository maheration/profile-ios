//
//  MaterialView.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-29.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = bounds.height / 2
    }
}
