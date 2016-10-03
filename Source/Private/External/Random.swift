//
//  Random.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/3/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//  Link https://gist.github.com/tiktuk/1dd83e6cdd2fede38be7

import UIKit
import Foundation

struct Random {
//    static func within<B: Comparable & ForwardIndexType(_ range: ClosedRange<B>) -> B {
//        let inclusiveDistance = <#T##Collection corresponding to your index##Collection#>.index(after: <#T##Collection corresponding to your index##Collection#>.distance(from: range.lowerBound, to: range.upperBound))
//        let randomAdvance = B.Distance(arc4random_uniform(UInt32(inclusiveDistance.toIntMax())).toIntMax())
//        return <#T##Collection corresponding to your index##Collection#>.index(range.lowerBound, offsetBy: randomAdvance)
//    }
    
//    static func within<B: protocol<Comparable, ForwardIndexType>>(range: ClosedInterval<B>) -> B {
//        let inclusiveDistance = range.start.distanceTo(range.end).successor()
//        let randomAdvance = B.Distance(arc4random_uniform(UInt32(inclusiveDistance.toIntMax())).toIntMax())
//        return range.start.advancedBy(randomAdvance)
//    }
    
//    static func within<B>(range: ClosedRange<B>) -> B where B: Comparable, B: BidirectionalCollection {
//        
//        let inclusiveDistance = range.lowerBound.distance(from: range.lowerBound.startIndex, to: range.upperBound.startIndex)
//        
////        let inclusiveDistance = index(after: 5) //range.lowerBound.distanceTo(range.end).successor()
//        let randomAdvance = B.Distance(arc4random_uniform(UInt32(inclusiveDistance.toIntMax())).toIntMax())
////        return range.start.advancedBy(randomAdvance)
//    }
    
    static func within(_ range: ClosedRange<Float>) -> Float {
        return (range.upperBound - range.lowerBound) * Float(Float(arc4random()) / Float(UInt32.max)) + range.lowerBound
    }
    
    static func within(_ range: ClosedRange<CGFloat>) -> CGFloat {
        return (range.upperBound - range.lowerBound) * CGFloat(CGFloat(arc4random()) / CGFloat(UInt32.max)) + range.lowerBound
    }
    
    static func within(_ range: ClosedRange<Double>) -> Double {
        return (range.upperBound - range.lowerBound) * Double(Double(arc4random()) / Double(UInt32.max)) + range.lowerBound
    }
    
    static func generate() -> Int {
        let start: Float = 0
        let end: Float = 1
        return Int(Random.within(start...end))
    }
    
    static func generate() -> Bool {
        return Random.generate() == 0
    }
    
    static func generate() -> Float {
        return Random.within(0.0...1.0)
    }
    
    static func generate() -> CGFloat {
        return CGFloat(Random.within(0.0...1.0))
    }
    
    static func generate() -> Double {
        return Random.within(0.0...1.0)
    }
}
