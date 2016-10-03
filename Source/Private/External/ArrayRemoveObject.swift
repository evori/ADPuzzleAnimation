//
//  ArrayRemoveObject.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/31/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//  thanks http://supereasyapps.com/blog/2015/9/22/how-to-remove-an-array-of-objects-from-a-swift-2-array-removeobjectsinarray

import UIKit

extension Array where Element: Equatable {
    mutating func removeObject(_ object: Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    
    mutating func removeObjectsInArray(_ array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}
