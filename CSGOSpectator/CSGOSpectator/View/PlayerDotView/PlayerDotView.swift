//
//  PlayerDotView.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 03.05.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class PlayerDotView: UIView, ReusableViewProtocol {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var button: UIButton!

    var action: (() -> Void)?

    private func commonInit() {
        Bundle.main.loadNibNamed("PlayerDotView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    @IBAction func buttonTapped() {
        action?()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width/2
    }

}
