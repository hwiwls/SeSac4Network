//
//  BookCollectionViewCell.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/17/24.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backgroundColoredView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func draw(_ rect: CGRect) {
        backgroundColoredView.layer.cornerRadius = 10
        backgroundColoredView.clipsToBounds = true
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
