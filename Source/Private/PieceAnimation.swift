//
//  PieceAnimation.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/9/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

extension CAAnimation {
    
    //MARK: - Interface
    
    static func basicForwardPieceAnimation(_ piece: Piece, velocity: Double, delay: CFTimeInterval, scale: Double) -> CAAnimation {
        func setDefaultValuesForAnimation(_ animation: CAAnimation) {
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        }
        
        func setAnimationDurationBasedOnVelocity(_ animation: CAAnimation, velocity: Double) {
            animation.duration = 10.0 / velocity
        }
        
        let moveAnimation: CABasicAnimation = CABasicAnimation(keyPath: "position")
        setDefaultValuesForAnimation(moveAnimation)
        setAnimationDurationBasedOnVelocity(moveAnimation, velocity: velocity)
        moveAnimation.fromValue = NSValue(cgPoint: piece.initialPosition)
        moveAnimation.toValue = NSValue(cgPoint: piece.desiredPosition)
        moveAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.0, 0.84, 0.49, 1.00)
        
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        setDefaultValuesForAnimation(scaleAnimation)
        setAnimationDurationBasedOnVelocity(scaleAnimation, velocity: velocity)
        scaleAnimation.fromValue = scale
        scaleAnimation.toValue = 1
        scaleAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.0, 0.84, 0.49, 1.00)
        
        let forwardAnimation = CAAnimationGroup()
        setDefaultValuesForAnimation(forwardAnimation)
        setAnimationDurationBasedOnVelocity(forwardAnimation, velocity: velocity)
        forwardAnimation.animations = [moveAnimation, scaleAnimation]
        forwardAnimation.beginTime = CACurrentMediaTime() + delay
        
        return forwardAnimation
    }
    
    static func basicBackwardPieceAnimation(_ piece: Piece, velocity: Double, delay: CFTimeInterval, scale: Double) -> CAAnimation {
        func setDefaultValuesForAnimation(_ animation: CAAnimation) {
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        }
        
        func setAnimationDurationBasedOnVelocity(_ animation: CAAnimation, velocity: Double) {
            animation.duration = 10.0 / velocity
        }
        
        let moveAnimation: CABasicAnimation = CABasicAnimation(keyPath: "position")
        setDefaultValuesForAnimation(moveAnimation)
        setAnimationDurationBasedOnVelocity(moveAnimation, velocity: velocity)
        moveAnimation.fromValue = NSValue(cgPoint: piece.initialPosition)
        moveAnimation.toValue = NSValue(cgPoint: piece.desiredPosition)
        moveAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 1.0, 0.0, 1.0, 0.67)
        
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        setDefaultValuesForAnimation(scaleAnimation)
        setAnimationDurationBasedOnVelocity(scaleAnimation, velocity: velocity)
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = scale
        scaleAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 1.0, 0.0, 1.0, 0.67)
        
        let forwardAnimation = CAAnimationGroup()
        setDefaultValuesForAnimation(forwardAnimation)
        setAnimationDurationBasedOnVelocity(forwardAnimation, velocity: velocity)
        forwardAnimation.animations = [moveAnimation, scaleAnimation]
        forwardAnimation.beginTime = CACurrentMediaTime() + delay
        
        return forwardAnimation
    }
    
}
