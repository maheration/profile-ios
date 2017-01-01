//
//  MaterialTextView.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-30.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class MaterialTextView: UITextView {

    override func awakeFromNib() {
        layer.cornerRadius = 18
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.5
        
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 0.08)
    }

}
