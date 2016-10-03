//
//  PiecePositionerTests.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import XCTest
import Nimble

@testable import ADPuzzleAnimation

class PiecePositionerTests: XCTestCase {

    let pieceContainerView = UIView(frame: CGRect(x: 60, y: 130, width: 200, height: 200))
    let keyWindow = UIApplication.shared.keyWindow
    let screenBounds = UIScreen.main.bounds
    
    override func setUp() {
        super.setUp()
        self.keyWindow?.addSubview(pieceContainerView)
    }
    
    override func tearDown() {
        self.pieceContainerView.removeFromSuperview()
        super.tearDown()
    }

    func testThatItShouldReturnPositionOutsideTopLeftCornerOfTheScreenForPieceInTopLeftAreaOfPiecesContainerView() {
        let pieceView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        let piece = Piece(pieceView: pieceView)
        for _ in 1...100 {
            let initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: 20, fromView: pieceContainerView, pieceScale: 2.5)
            if(initialPosition.x < -(pieceContainerView.frame).minX){
                expect(initialPosition.x) < -(pieceContainerView.frame).minX
                expect(initialPosition.y) < (pieceContainerView.bounds).midY
            }
            else {
                expect(initialPosition.x) < (pieceContainerView.bounds).midX
                expect(initialPosition.y) < -(pieceContainerView.frame).minY
            }
        }
    }
    
    func testThatItShouldReturnPositionOutsideTopRightCornerOfTheScreenForPieceInTopRightAreaOfPiecesContainerView() {
        let pieceView = UIView(frame: CGRect(x: 120, y: 20, width: 20, height: 20))
        let piece = Piece(pieceView: pieceView)
        for _ in 1...100 {
            let initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: 20, fromView: pieceContainerView, pieceScale: 2.5)
            if(initialPosition.x > (screenBounds).width - (pieceContainerView.frame).minX){
                expect(initialPosition.x) > (screenBounds).width - (pieceContainerView.frame).minX
                expect(initialPosition.y) < (pieceContainerView.bounds).midY
            }
            else {
                expect(initialPosition.x) > (pieceContainerView.bounds).midX
                expect(initialPosition.y) < -(pieceContainerView.frame).minY
            }
        }
    }
    
    func testThatItShouldReturnPositionOutsideBottomLeftCornerOfTheScreenForPieceInBottomLeftAreaOfPiecesContainerView() {
        let pieceView = UIView(frame: CGRect(x: 20, y: 120, width: 20, height: 20))
        let piece = Piece(pieceView: pieceView)
        for _ in 1...100 {
            let initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: 20, fromView: pieceContainerView, pieceScale: 2.5)
            if(initialPosition.x < -(pieceContainerView.frame).minX){
                expect(initialPosition.x) < -(pieceContainerView.frame).minX
                expect(initialPosition.y) > (pieceContainerView.bounds).midY
            }
            else {
                expect(initialPosition.x) < (pieceContainerView.bounds).midX
                expect(initialPosition.y) > (screenBounds).height - (pieceContainerView.frame).minY
            }
        }
    }
    
    func testThatItShouldReturnPositionOutsideBottomRightCornerOfTheScreenForPieceInBottomRightAreaOfPiecesContainerView() {
        let pieceView = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        let piece = Piece(pieceView: pieceView)
        for _ in 1...100 {
            let initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: 20, fromView: pieceContainerView, pieceScale: 2.5)
            if(initialPosition.x > (screenBounds).width - (pieceContainerView.frame).minX){
                expect(initialPosition.x) > (screenBounds).width - (pieceContainerView.frame).minX
                expect(initialPosition.y) > (pieceContainerView.bounds).midY
            }
            else {
                expect(initialPosition.x) > (pieceContainerView.bounds).midX
                expect(initialPosition.y) > (screenBounds).height - (pieceContainerView.frame).minY
            }
        }
    }
    
    func testThatItShouldReturnCorrectCornerForPiece() {
        let pieceView1 = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        let piece1 = Piece(pieceView: pieceView1)
        expect(PiecePositioner.cornerForPosition(piece1.originalPosition, inRect: self.pieceContainerView.bounds)).to(equal(Corner.TopLeft))
        
        let pieceView2 = UIView(frame: CGRect(x: 120, y: 20, width: 20, height: 20))
        let piece2 = Piece(pieceView: pieceView2)
        expect(PiecePositioner.cornerForPosition(piece2.originalPosition, inRect: self.pieceContainerView.bounds)).to(equal(Corner.TopRight))
        
        let pieceView3 = UIView(frame: CGRect(x: 20, y: 120, width: 20, height: 20))
        let piece3 = Piece(pieceView: pieceView3)
        expect(PiecePositioner.cornerForPosition(piece3.originalPosition, inRect: self.pieceContainerView.bounds)).to(equal(Corner.BottomLeft))
        
        let pieceView4 = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        let piece4 = Piece(pieceView: pieceView4)
        expect(PiecePositioner.cornerForPosition(piece4.originalPosition, inRect: self.pieceContainerView.bounds)).to(equal(Corner.BottomRight))
    }

}
