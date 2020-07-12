//
//  DetailViewController.swift
//  Note Application
//
//  Created by Andrew Arpin on 2020-07-12.
//  Copyright © 2020 Andrew Arpin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteTextTextView: UITextView!
    @IBOutlet weak var noteDate: UILabel!
    
    // MARK: - Properties
    var detailItem: Note? {
           didSet {
               // Update the view.
               configureView()
           }
       }
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let topicLabel = noteTitleLabel,
               let dateLabel = noteDate,
               let textView = noteTextTextView {
                topicLabel.text = detail.title
                dateLabel.text = NoteDateHelper.convertDate(Date.init(seconds: detail.time))
                textView.text = detail.text
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }


}

