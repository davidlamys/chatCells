//
//  DetailViewController.swift
//  test
//
//  Created by David Lam on 14/2/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

enum TextType: String {
    case null = ""
    case shortText = "H"
    case mediumText = "Hello"
    case longText = "Himenaeos, nisi phasellus quam cursus ligula scelerisque dictum vestibulum cum rhoncus ut platea. Cras nulla class vel litora proin at placerat cum urna penatibus suscipit tempus.Himenaeos, nisi phasellus quam cursus ligula scelerisque dictum vestibulum cum rhoncus ut platea. Cras nulla class vel litora proin at placerat cum urna penatibus suscipit tempus.Himenaeos, nisi phasellus quam cursus ligula scelerisque dictum vestibulum cum rhoncus ut platea. Cras nulla class vel litora proin at placerat cum urna penatibus suscipit tempus."
}

enum MessageType: String {
    case sent
    case received
}

public struct DetailViewConfigurator {
    var showImage: Bool
    var textType: TextType
    var messageType: MessageType
    
    func description() -> String {
        return "Image: \(showImage), text: \(textType.hashValue), sent: \(messageType.rawValue)"
    }
}

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var bubble: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var mediaViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var mediaViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mediaViewWidth: NSLayoutConstraint!
    @IBOutlet weak var mediaTrailingConstraint: NSLayoutConstraint!
    
    
    var configurator: DetailViewConfigurator!
    
    @IBOutlet weak var leftAvatarFixedWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var rightAvatarFixedWidthConstraint: NSLayoutConstraint!
    func configureView() {
        // Update the user interface for the detail item.
        if let config = self.configurator {
            if let label = self.detailDescriptionLabel {
                label.text = config.description()
            }
            
            textLabel.text = config.textType.rawValue
            mediaViewHeight.constant = config.showImage ? 135.0 : 0.0
            mediaViewWidth.constant = config.showImage ? 183.0 : 0.0
            mediaViewTopConstraint.constant = config.showImage ? 8.0 : 0
            
            mediaTrailingConstraint.isActive = config.showImage
            self.rightAvatarFixedWidthConstraint.isActive = (config.messageType == .sent)
            self.leftAvatarFixedWidthConstraint.isActive = (config.messageType == .received)
            self.bubble.setNeedsLayout()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

