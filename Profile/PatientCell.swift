//
//  PatientCell.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-29.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class PatientCell: UITableViewCell {
    
    @IBOutlet weak var patientName: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(patient: Patient) {
        patientName.text = patient.fullName
    }

}
