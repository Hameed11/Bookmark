//
//  LinksTableViewCell.swift
//  Bookmark
//
//  Created by Hameed Abdullah on 7/3/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

class LinksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    func confCell(link: Link) {
        
        descriptionLabel.text = link.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        guard let date = link.date else { return }
        timestampLabel.text = dateFormatter.string(from: date)
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
