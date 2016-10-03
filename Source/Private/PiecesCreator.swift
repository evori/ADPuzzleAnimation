//
//  PiecesCreator.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

class PiecesCreator {
    static func createPiecesFromView(_ view: UIView, pieceSideSize: CGFloat) -> [Piece] {
        var pieces: [Piece] = []
        let size = view.frame.size
        
        let fromViewSnapshot = view.snapshotView(afterScreenUpdates: false)
        
        let width = pieceSideSize
        let height = pieceSideSize
        
        for x in stride(from: CGFloat(0), through: size.width, by: width) {
            for y in stride(from: CGFloat(0), through: size.height, by: height) {
                let pieceRegion = CGRect(x: x, y: y , width: min(width, size.width - x), height: min(height, size.height - y))
                let pieceView = fromViewSnapshot!.resizableSnapshotView(from: pieceRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
                pieceView!.frame = pieceRegion
                let piece = Piece(pieceView: pieceView!)
                piece.corner = PiecePositioner.cornerForPosition(piece.originalPosition, inRect: view.bounds)
                pieces.append(piece)
            }
        }
        pieces.shuffleInPlace()
        return pieces
    }
}
