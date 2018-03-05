//
//  Extensions.swift
//  VideoDownload
//
//  Created by HOANGHUNG on 3/5/18.
//  Copyright © 2018 HOANGHUNG. All rights reserved.
//

import Foundation

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
}
