//
//  String.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 19.05.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

extension String {
    var isEmail: Bool {
        guard !self.lowercased().hasPrefix("mailto:") else { return false }
        guard let emailDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        let matches = emailDetector.matches(in: self, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: self.count))
        guard matches.count == 1 else { return false }
        return matches[0].url?.scheme == "mailto"
    }
    
    var flagEmoji: String? {
        return String(String.UnicodeScalarView(self.uppercased().unicodeScalars.flatMap { UnicodeScalar(127397 + $0.value) }))
    }
}
