//
//  ChatCell.swift
//  Chatterbox
//
//  Created by Manik Narang on 2/22/18.
//  Copyright © 2018 Manik Narang. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageCellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
