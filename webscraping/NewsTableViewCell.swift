//
//  NewsTableViewCell.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/17/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
