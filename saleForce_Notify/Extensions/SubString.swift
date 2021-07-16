//
//  SubString.swift
//  TasReference
//
//  Created by nextage on 2019/11/05.
//  Copyright © 2019 nextage. All rights reserved.
//

import Foundation
extension String {
    func substring(from: Int, to: Int) -> String {
        if(self.count < to){
            let start = index(startIndex, offsetBy: from)
            let end = index(start, offsetBy: self.count - from)
            return String(self[start ..< end])
        }
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
}
