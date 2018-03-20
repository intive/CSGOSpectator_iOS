//
//  Extensions.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

extension Int {
    func secondsToMinutesSeconds() -> (minutes: Int, seconds: Int) {
        return (self / 60, self % 60)
    }
}
