//
//  myCollectionViewCell.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/10/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit

class myCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!

    static let identifier = "myCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(with image: UIImage){
        imageView.image = image
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "myCollectionViewCell", bundle: nil)
    }
    
    
}
