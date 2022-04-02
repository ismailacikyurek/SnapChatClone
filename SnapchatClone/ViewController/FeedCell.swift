//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by İSMAİL AÇIKYÜREK on 2.04.2022.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var feedUsernameLabel: UILabel!
    @IBOutlet weak var feedimageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
