//
//  PatientMedsCell.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-05.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class PatientMedsCell: UITableViewCell {

    @IBOutlet weak var medName : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(med: Medication) {
        medName.text = med.name
    }

}
