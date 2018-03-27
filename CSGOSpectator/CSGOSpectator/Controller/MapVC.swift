//
//  MapVC.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 25.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class MapVC: UIViewController {
    
    @IBOutlet var mapImageView: UIImageView!
    
    var currentMatch: Game? {
        didSet {
            print((currentMatch?.map)!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
