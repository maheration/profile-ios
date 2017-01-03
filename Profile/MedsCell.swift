//
//  MedsCell.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-03.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class MedsCell: UITableViewCell {
    
    @IBOutlet weak var medsLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(meds: Medication) {
        medsLbl.text = meds.name
    }

}
