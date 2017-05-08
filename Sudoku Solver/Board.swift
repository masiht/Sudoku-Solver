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
    
    
    /// Prints a board
    func toString()  {
        
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
    /// - Parameter row: row location
    /// - Parameter col: column location
    /// - Parameter board: given board
    /// - Returns: Bool
    func solve() -> Bool {
        return solve_cell(0, col: 0, board: self.board)
    }
    
    /// Solves for a single cell
    /// - Parameter row: row location
    /// - Parameter col: column location
    /// - Parameter board: given board
    /// - Returns: Bool
    private func solve_cell(row: Int, col: Int, board: [[Int]]) -> Bool {
        
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
    private func isValidSolution(row: Int, col: Int, board: [[Int]], newCell: Int) -> Bool {
        
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