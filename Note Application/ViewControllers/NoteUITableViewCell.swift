//
//  NoteUITableViewCell.swift
//  Note Application
//
//  Created by Andrew Arpin on 2020-07-12.
//  Copyright © 2020 Andrew Arpin. All rights reserved.
//

import UIKit

class NoteUITableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ note: Note) {
        self.titleLabel.text = note.title
        self.detailLabel.text = note.text
        self.timeLabel.text = NoteDateHelper.convertDate(Date.init(seconds: note.time))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
