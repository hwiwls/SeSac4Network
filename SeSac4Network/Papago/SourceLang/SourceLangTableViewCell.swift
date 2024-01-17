//
//  SourceLangTableViewCell.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/17/24.
//

import UIKit

class SourceLangTableViewCell: UITableViewCell {

    @IBOutlet weak var srcLangLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
