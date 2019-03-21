//
//  ButtonStyler.swift
//  startUp
//
//  Created by Mladen Penev on 10.03.19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import UIKit
import UIKit
@IBDesignable class AwesomeView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    func initNib() {
        let bundle = Bundle(for: AwesomeView.self)
        bundle.loadNibNamed("AwesomeView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBInspectable var button1Title: String = "" {
        didSet {
            button1.setTitle(button1Title, for: .normal)
        }
    }
}
