//
//  ADPuzzleAnimation.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

public typealias PuzzleAnimationCompletion = (_ animation: PuzzleAnimation, _ finished: Bool) -> Void

/// The `PuzzleAnimation` defines the abstract animation class
open class PuzzleAnimation {
    
    /// Called when animation completed, stoped or failed
    /// @note You can set it any time even during the animation
    open var animationCompletion: PuzzleAnimationCompletion?
    
    /// Information whether animation is currently running or not
    fileprivate(set) open var isAnimating: Bool = false
    
    fileprivate let configuration: PuzzleAnimationConfiguration
    fileprivate let pieces: [Piece]
    fileprivate let viewToAnimate: UIView
    fileprivate var piecesContainerView: UIView?
    
    /**
     Desiganted initalizer for puzzle animation and it's subclasses
     
     - parameter viewToAnimate: view to render into pieces
     - parameter configuration: animation configuration
     
     - returns: newly created animation instance
     */
    public init(viewToAnimate: UIView, configuration: PuzzleAnimationConfiguration = PuzzleAnimationConfiguration()) {
        self.configuration = configuration
        self.pieces = PiecesCreator.createPiecesFromView(viewToAnimate, pieceSideSize: configuration.pieceSide)
        self.viewToAnimate = viewToAnimate
    }
    
    //MARK: - Interface
    
    /**
     Starts the animation. Makes view to animate hidden
    */
    open func start() {
        let piecesContainerView = self.piecesContainerViewFromViewToAnimate(self.viewToAnimate)
        self.viewToAnimate.superview?.addSubview(piecesContainerView)
        self.viewToAnimate.isHidden = true
        self.isAnimating = true
    }
    
    /**
     Stops the animation. Removes all pieces from superview. Makes view to animate visible
     */
    open func stop() {
        self.finish()
    }
    
    //MARK: - Helpers
    
    fileprivate func piecesContainerViewFromViewToAnimate(_ viewToAnimate: UIView) -> UIView {
        let piecesContainerView = UIView(frame: self.viewToAnimate.frame)
        piecesContainerView.clipsToBounds = false
        self.piecesContainerView = piecesContainerView
        return piecesContainerView
    }
    
    fileprivate func finish() {
        self.piecesContainerView?.removeFromSuperview()
        self.viewToAnimate.isHidden = false
        self.isAnimating = false
    }
}

/// The `ForwardPuzzleAnimation` defines the animation to create a full view from pieces
open class ForwardPuzzleAnimation: PuzzleAnimation {
    
    fileprivate let pieceAnimator: PieceForwardAnimator
    
    public override init(viewToAnimate: UIView, configuration: PuzzleAnimationConfiguration = PuzzleAnimationConfiguration()) {
        pieceAnimator = PieceForwardAnimator(animationConfiguration: configuration)
        super.init(viewToAnimate: viewToAnimate, configuration: configuration)
    }
    
    /**
     @see PuzzleAnimation start()
     */
    open override func start() {
        if self.isAnimating {
            return
        }
        
        super.start()
        for piece in self.pieces {
            piece.initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: self.configuration.pieceSide, fromView: self.piecesContainerView!, pieceScale: self.configuration.animationScale)
            piece.desiredPosition = piece.originalPosition
            self.piecesContainerView!.addSubview(piece.view)
        }
        
        self.pieceAnimator.addAnimationForPieces(self.pieces) {
            [weak self] (finished: Bool) in
            self?.finish()
            self?.animationCompletion?(self!, finished)
        }
    }
    
    /**
     @see PuzzleAnimation stop()
     */
    open override func stop() {
        if !self.isAnimating {
            return
        }
        
        super.stop()
        self.pieceAnimator.removeAnimationFromPieces(self.pieces)
        self.animationCompletion?(self, false)
    }
}

/// The `BackwardPuzzleAnimation` defines the animation to split view into pieces
open class BackwardPuzzleAnimation: PuzzleAnimation {
    
    fileprivate let pieceAnimator: PieceBackwardAnimator
    
    public override init(viewToAnimate: UIView, configuration: PuzzleAnimationConfiguration = PuzzleAnimationConfiguration()) {
        pieceAnimator = PieceBackwardAnimator(animationConfiguration: configuration)
        super.init(viewToAnimate: viewToAnimate, configuration: configuration)
    }
    
    /**
     @see PuzzleAnimation start()
     */
    open override func start() {
        if self.isAnimating {
            return
        }
        
        super.start()
        for piece in self.pieces {
            piece.initialPosition = piece.originalPosition
            piece.desiredPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: self.configuration.pieceSide, fromView: self.piecesContainerView!, pieceScale: self.configuration.animationScale)
            self.piecesContainerView!.insertSubview(piece.view, at: 0)
        }
        
        self.pieceAnimator.addAnimationForPieces(self.pieces) {
            [weak self] (finished: Bool) in
            self?.finish()
            self?.animationCompletion?(self!, finished)
        }
    }
    
    /**
     @see PuzzleAnimation stop()
     */
    open override func stop() {
        if !self.isAnimating {
            return
        }
        super.stop()
        self.pieceAnimator.removeAnimationFromPieces(self.pieces)
        self.animationCompletion?(self, false)
    }
}
