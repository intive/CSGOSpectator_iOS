//
//  PlayerDrawerView.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 12.05.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class PlayerDrawerView: UIView, ReusableViewProtocol {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var healthBar: UIView!
    @IBOutlet weak var armorBar: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var currentHealth: UIView!
    @IBOutlet weak var currentArmor: UIView!
    
    var closeCallback: (() -> Void)?
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("PlayerDrawerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func closePressed() {
        closeCallback?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        mainView.layer.cornerRadius = 6
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.gray.cgColor
    }

}
