//
//  MaterialTxtFld.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-25.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class MaterialTxtFld: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 18.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.5
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        
        self.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 0.08)
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
}
