//
//  Model.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import Foundation
import SwiftUI
import Combine


class GameModel: ObservableObject {
    var library: PuzzleLibrary
    var curr: Int
    @Published var lamps: [[Int]]
    
    init() {
        self.curr = 0
        self.library = PuzzleLibrary()
        self.lamps = [[]]
        let sampleBoard = [
            [0, 1, 2, 3, 4, 5, 6],
            [0, 1, 2, 3, 4, 5, 6],
            [0, 1, 2, 3, 4, 5, 6],
            [0, 1, 2, 3, 4, 5, 6],
            [0, 1, 2, 3, 4, 5, 6],
            [0, 1, 2, 3, 4, 5, 6],
            [0, 1, 2, 3, 4, 5, 6]
        ]
        self.library.addPuzzle(puzzle: Puzzle(board: sampleBoard))
    }
    
    func addLamp(r: Int, c: Int) {
        if(getActivePuzzle().getCellType(r: r, c: c) == CellType.CORRIDOR) {
            lamps[r][c] = 1
        }
    }
    
    func removeLamp(r: Int, c: Int) {
        func addLamp(r: Int, c: Int) {
            if(getActivePuzzle().getCellType(r: r, c: c) == CellType.CORRIDOR) {
                lamps[r][c] = 0
            }
        }
    }
    
    func isLit(r: Int, c: Int) -> Bool {
        if(isLamp(r: r, c: c)) {
            return true
        }
        return searchDirection(r: r, c: c, d: .N) || searchDirection(r: r, c: c, d: .S) || searchDirection(r: r, c: c, d: .E) || searchDirection(r: r, c: c, d: .W)
    }
    
    func isLamp(r: Int, c: Int) -> Bool {
        if(getActivePuzzle().getCellType(r: r, c: c) == CellType.CORRIDOR) {
            return lamps[r][c] == 1
        } else {
            return false
        }
    }
    
    func isLampIllegal(r: Int, c: Int) -> Bool {
        if(isLamp(r: r, c: c)) {
            return true
        }
        return searchDirection(r: r, c: c, d: .N) || searchDirection(r: r, c: c, d: .S) || searchDirection(r: r, c: c, d: .E) || searchDirection(r: r, c: c, d: .W)
    }
    
    func getActivePuzzle() -> Puzzle {
        return library.getPuzzle(index: curr)
    }
    
    func getActivePuzzleIndex() -> Int {
        return curr
    }
    
    func setActivePuzzleIndex(index: Int) {
        curr = index
        resetPuzzle()
    }

    func getPuzzleLibrarySize() -> Int {
        return library.size()
      }
    
    func resetPuzzle() {
        for i in 0 ... getActivePuzzle().getWidth() - 1 {
            for j in 0 ... getActivePuzzle().getHeight() - 1 {
                lamps[i][j] = 0
            }
        }
    }
    
    func isSolved() -> Bool {
        for r in 0 ... getActivePuzzle().getWidth() - 1 {
            for c in 0 ... getActivePuzzle().getHeight() - 1 {
                switch(getActivePuzzle().getCellType(r: r, c: c)) {
                case .CORRIDOR:
                    if(!isLit(r: r, c: c)) {
                        return false
                    }
                    if(isLamp(r: r, c: c)) {
                        if(isLampIllegal(r: r, c: c)) {
                            return false
                        }
                    }
                    break
                case .CLUE:
                    if(!isClueSatisfied(r: r, c: c)) {
                        return false
                    }
                    break
                case .WALL:
                    break
                }
            }
        }
        return true
    }
    
    func isClueSatisfied(r: Int, c: Int) -> Bool {
        if(getActivePuzzle().getCellType(r: r, c: c) != CellType.CLUE) {
            return false
        }
        let expectedNumOfLamps = getActivePuzzle().getClue(r: r, c: c);
        var numOfLamps = 0;
        numOfLamps += checkDirection(r: r, c: c, d: .N);
        numOfLamps += checkDirection(r: r, c: c, d: .S);
        numOfLamps += checkDirection(r: r, c: c, d: .E);
        numOfLamps += checkDirection(r: r, c: c, d: .W);
        return numOfLamps == expectedNumOfLamps;
    }

    func searchDirection(r: Int, c: Int, d: Direction) -> Bool {
        var r_new = r
        var c_new = c
        
        switch d {
        case .N:
            r_new -= 1
            break
        case .S:
            r_new += 1
            break
        case .E:
            c_new += 1
            break
        case .W:
            c_new -= 1
            break
        }
        
        if(c_new < 0 || c >= getActivePuzzle().getWidth() || r_new < 0 || r >= getActivePuzzle().getHeight()) {
            return false
        } else if (getActivePuzzle().getCellType(r: r, c: c) == CellType.WALL || getActivePuzzle().getCellType(r: r, c: c) == CellType.CORRIDOR) {
            return false
        } else {
            if (isLamp(r: r, c: c)){
                return true
            } else {
                return searchDirection(r: r, c: c, d: d)
            }
        }
    }
    
    func checkDirection(r: Int, c: Int, d: Direction) -> Int {
        var r_new = r
        var c_new = c
        
        switch d {
        case .N:
            r_new -= 1
            break
        case .S:
            r_new += 1
            break
        case .E:
            c_new += 1
            break
        case .W:
            c_new -= 1
            break
        }
        
        if(c_new < 0 || c >= getActivePuzzle().getWidth() || r_new < 0 || r >= getActivePuzzle().getHeight()) {
            return 0
        } else if (getActivePuzzle().getCellType(r: r, c: c) == CellType.WALL || getActivePuzzle().getCellType(r: r, c: c) == CellType.CORRIDOR) {
            return 0
        } else {
            if (isLamp(r: r, c: c)){
                return 1
            } else {
                return 0
            }
        }
    }
}

class PuzzleLibrary {
    private var puzzles: [Puzzle]
    
    init() {
        puzzles = []
    }
    
    func addPuzzle(puzzle: Puzzle) {
        puzzles.append(puzzle)
    }
    
    func getPuzzle(index: Int) -> Puzzle {
        return puzzles[index]
    }
    
    func size() -> Int {
        return puzzles.count
    }
}

class Puzzle {
    private var board: [[Int]]
    
    init(board: [[Int]]) {
        self.board = board
//        if(self.board.count == 0) {
//            self.board.append([1])
//        }
    }
    
    func getWidth() -> Int {
        self.board.count
    }
    
    func getHeight() -> Int {
        self.board[0].count
    }
    
    func getCellType(r: Int, c: Int) -> CellType {
        let c = self.board[r][c]
        
        if (c >= 0 && c <= 4) {
            return CellType.CLUE
        } else if(c == 5) {
            return CellType.WALL
        } else {
            return CellType.CORRIDOR
        }
    }
    
    func getClue(r: Int, c: Int) -> Int {
        if(getCellType(r: r, c: c) == CellType.CLUE) {
            return self.board[r][c]
        } else {
            return -1
        }
    }
}

enum Direction {
    case N
    case S
    case E
    case W
}

enum CellType {
    case CLUE
    case WALL
    case CORRIDOR
}
