 //
//  CustomTableViewCell.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/11/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var cases: UILabel!
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
