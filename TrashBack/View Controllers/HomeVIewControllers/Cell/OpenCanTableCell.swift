//
//  OpenCanTableCell.swift
//  TrashBack
//
//  Created by angrz singh on 29/01/22.
//

import UIKit

class OpenCanTableCell: UITableViewCell {

    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var indicatorView: DesignableView!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
