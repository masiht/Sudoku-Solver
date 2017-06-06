//
//  Board.swift
//  Sudoku Solver
//
//  Created by Masih Tabrizi on 4/30/17.
//  Copyright © 2017 Tabrizi. All rights reserved.
//

import Foundation

class Board {
    
    var board : [[Int]]!
    var size: Int!
    
    init() {
        size = 9
        board = Array(repeating: Array(repeating: 0, count: size), count: size)
    }
    
    init(_ board : [[Int]]) {
        self.board = board
        
        
        if board.count == board[0].count {
            self.size = board.count
        
        } else {
            
            //TODO
            print("Invalid input")
            self.size = 9
        }
        
    }
    
    /// ## Clear Method
    /// Public Clear Method: Clears the Board
    /// - Returns: Bool
    public func clearBoard() -> Bool {
        
        guard board != nil else {
            return false
        }
        
        board = Array(repeating: Array(repeating: 0, count: size), count: size)
        return true
    }
    
    
    /// Prints a board
    public func toString()  {
        
        guard board != nil else {
            print("board not available")
            return
        }
        
        print("---------------------------")
        for row in board {
            print(row)
        }
        print("---------------------------")
    }
    
    /// ## Solver Method
    /// Public Solve Method: Solves a Board
    /// - Returns: Bool
    public func solve() -> Bool {
        if solvable() {
            
            return solve_cell(0, col: 0, board: self.board)
            
        } else {
            
            print("Not solvable")
            return false
        }
        
    }
    
    
    /// Checks a board to see if a valid solvable input board
    /// - Returns: Bool
    func solvable() -> Bool {
        
        var rows : [[Int]] = Array(repeating: Array(repeating: 0, count: size), count: size)
        var cols : [[Int]] = Array(repeating: Array(repeating: 0, count: size), count: size)
        var sqrs : [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 0, count: size), count: size/3), count: size/3)
        
        for (r, row) in board.enumerated() {
            for (c, cell) in row.enumerated() {
                let number = cell - 1
                
                if cell > 0 {
                    
                    if rows[r][number] > 0 {
                        
                        return false
                    }
                    
                    if cols[c][number] > 0 {
                        
                        return false
                    }
                    
                    if sqrs[r/3][c/3][number] > 0 {
                        
                        return false
                    }
                    
                    rows[r][number] += 1
                    cols[c][number] += 1
                    sqrs[r/3][c/3][number] += 1
                    
                }
            }
        }
        
        return true
    }
    
    /// Solves for a single cell
    /// - Parameter row: row location
    /// - Parameter col: column location
    /// - Parameter board: given board
    /// - Returns: Bool
    fileprivate func solve_cell(_ row: Int, col: Int, board: [[Int]]) -> Bool {
        
        var row = row
        var col = col
        var board = board
        
        if row == self.size {
            row = 0
            col += 1
            if col == self.size {
                self.board = board
                return true
            }
        }
        
        if board[row][col] != 0 {
            return solve_cell(row + 1, col: col, board: board)
        }
        
        for val in 1...self.size {
            if isValidSolution(row, col: col, board: board, newCell: val) {
                
                board[row][col] = val
                if solve_cell(row + 1, col: col, board: board) {
                    return true
                }
            }
        }
        
        board[row][col] = 0
        
        return false
    }
    
    /// Checks if the suggested value is a good fit to the board
    /// - Parameter row: suggested value row location
    /// - Parameter col: suggested value column location
    /// - Parameter board: given board
    /// - Parameter newCell: suggested value
    /// - Returns: Bool
    fileprivate func isValidSolution(_ row: Int, col: Int, board: [[Int]], newCell: Int) -> Bool {
        
        for check in 0..<self.size {
            if newCell == board[check][col] {
                return false
            }
        }
        
        for check in 0..<self.size {
            if newCell == board[row][check] {
                return false
            }
        }
        
        let xBox = row / 3 * 3
        let yBox = col / 3 * 3
        
        for x in 0..<3 {
            for y in 0..<3 {
                if newCell == board[(xBox + x)][(yBox + y)] {
                    return false
                }
            }
        }
        
        return true
    }
    
}
