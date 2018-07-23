//
//  Card.swift
//  Concentration
//
//  Created by Changyu Yan on 11/20/17.
//  Copyright © 2017 Changyu Yan. All rights reserved.
//

import Foundation

// Major difference between struct and class in swift
// 1. Struct does not have inheritance, class does
// 2. Structs are are value-types, classes are reference types
// In swift, arrays, strings, ints, dicts are all structs
// Copy on right semantics

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0;
    
    private static func getUniqueIdentifier() -> Int
    {
        identifierFactory += 1
        return identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
