//
//  EventCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    static let identifier = "EventCell"

    //outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    
    //data source
    var event: Event! { didSet{ reloadData() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func reloadData(){
        let eventDate = event.time.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        timeLabel.text = dateFormatter.string(from: eventDate)
        descriptionTV.text = event.description
    }

}
