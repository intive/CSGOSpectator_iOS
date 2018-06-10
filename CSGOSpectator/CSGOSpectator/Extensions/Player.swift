//
//  Player.swift
//  CSGOSpectator
//
//  Created by Kacper Woźniak on 10/06/2018.
//  Copyright © 2018 intive. All rights reserved.
//

import CSGOSpectatorKit

extension Player {

    var rotation: CGFloat {
        let vector = CGVector(dx: 0, dy: 1)
        return atan2(vector.dy, vector.dx) - atan2(forward.dy, forward.dx)
    }

}
