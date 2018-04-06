//
//  ResultsHeaderView.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

protocol ReusableViewProtocol {     //Remember to call super initializer for those methods
    init(frame: CGRect)
    init?(coder aDecoder: NSCoder)
}

class ResultsHeaderView: UIView, ReusableViewProtocol {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ResultsHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func updateWithGameData(_ match: Game?) {
        if let game = match {
            roundLabel.text = "Round \(game.round)"
            scoreLabel.text = "\(game.teamCT.score) - \(game.teamT.score)"
            remainingTimeLabel.text = String(format: "%02i:%02i", arguments: [game.phaseEndsIn.secondsToMinutesSeconds().minutes, game.phaseEndsIn.secondsToMinutesSeconds().seconds])
        } else {
            roundLabel.text = ""
            scoreLabel.text = "Couldn't load now playing game"
            remainingTimeLabel.text = ""
        }
    }

}
