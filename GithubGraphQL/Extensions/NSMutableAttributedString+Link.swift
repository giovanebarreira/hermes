//
//  NSMutableAttributedString+Link.swift
//  GithubGraphQL
//
//  Created by Avanade on 15/03/22.
//  Copyright © 2022 test. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
           self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
