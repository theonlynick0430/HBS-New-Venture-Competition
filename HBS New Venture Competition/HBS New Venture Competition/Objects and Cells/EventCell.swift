//
//  EventCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var event: Event! { didSet { setData() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setData(){
        timeLabel.text = event.time.dateValue().description
        descriptionLabel.text = event.description
    }

}
