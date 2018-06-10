//
//  HistoryTableViewCell.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 10.06.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        helpView.layer.cornerRadius = 8
        helpView.layer.borderWidth = 2
        helpView.layer.borderColor = UIColor.darkGray.cgColor
    }

    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var helpView: UIView!
}
