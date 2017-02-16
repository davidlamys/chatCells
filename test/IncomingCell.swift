//
//  IncomingCell.swift
//  test
//
//  Created by David Lam on 14/2/17.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class IncomingCell: UITableViewCell {
    var configurator: DetailViewConfigurator!

    @IBOutlet weak var bubbleFrame: UIView!
    
    @IBOutlet weak var spacerFixedWidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var mediaView: UIImageView!
    
    @IBOutlet weak var mediaViewAspectRatio: NSLayoutConstraint!
    
    @IBOutlet weak var mediaViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mediaViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var messageTopSpacer: NSLayoutConstraint!

    @IBOutlet weak var messageBottomSpacer: NSLayoutConstraint!
    
    @IBOutlet weak var messageLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        messageTopSpacer.constant = 8.0
        messageBottomSpacer.constant = 8.0
    }
    
    func configureCell() {
        guard let config = configurator else {
            return
        }
        bubbleFrame.layer.cornerRadius = 0.2
     
        messageLabel.text = config.textType.rawValue
        
        if config.textType == .null {
            messageTopSpacer.constant = 0.0
            messageBottomSpacer.constant = 0.0
        } else {
            messageTopSpacer.constant = 8.0
            messageBottomSpacer.constant = 8.0
        }
        
        if config.showImage {
            mediaViewHeight.constant = mediaView.frame.width * 0.5
//            mediaViewTrailingConstraint.isActive = true
        } else {
            mediaViewHeight.constant = 0.0
//            mediaViewTrailingConstraint.isActive = false
        }
        
        self.bubbleFrame.setNeedsLayout()
    }
}
