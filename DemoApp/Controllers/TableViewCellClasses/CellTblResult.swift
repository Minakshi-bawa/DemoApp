//
//  CellTblResult.swift
//  DemoApp
//
//  Created by Minakshi Bawa on 30/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import UIKit

class CellTblResult: UITableViewCell {
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblMarks: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
