//
//  OutgoingCell.swift
//  test
//
//  Created by David Lam on 14/2/17.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class OutgoingCell: UITableViewCell {
    
    @IBOutlet weak var labelHolder: UIView!
    @IBOutlet weak var mediaView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var configuator: DetailViewConfigurator!
    
    func removeMediaView() {
        mediaView?.removeFromSuperview()
    }
    
    func configureView() {
        guard let config = configuator else {
            return
        }
        
        messageLabel.text = config.textType.rawValue
        if config.textType == .null {
            labelHolder.isHidden = true
            messageLabel.isHidden = true
        } else {
            labelHolder.isHidden = false
            messageLabel.isHidden = false
        }
        self.layoutSubviews()
    }
}
