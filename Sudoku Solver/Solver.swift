//
//  Solver.swift
//  Sudoku Solver
//
//  Created by Masih Tabrizi on 4/28/17.
//  Copyright © 2017 Tabrizi. All rights reserved.
//

import Foundation


class Solver : NSObject {
    
    class func solve(_ board:[[Int]]) -> Bool {
        var board = board
        
        if !checkBoard(board) {
            return false
        }
        
        for (i, row) in board.enumerated() {
            for (j, num) in row.enumerated() {
                
                // empty cell
                if num == 0 {
                    
                    for newnum in 1...9 {
                        
                        if isValidCell(board, col: i, row: j, cell: newnum) {
                            board[i][j] = newnum
                        }
                        
                        if solve(board) {
                            
                            return true
                        
                        } else {
                            
                            board[i][j] = 0
                        }
                        
                    }
                    
                    return false
                    
                }
                // end if empty cell
            }
        }
        print("--------------")
        for row in board {
            print(row)
        }
        print("--------------")
        return true
    }
    
    
    class func isValidCell(_ board:[[Int]], col: Int, row: Int, cell:Int) -> Bool {
        
        for i in 0..<9 {
            
            if board[i][col] != 0 && board[i][col] == cell {
                return false
            }
            
            if board[row][i] != 0 && board[row][i] == cell {
                return false
            }
            
            if  board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] != 0 &&
                board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == cell {
                return false
            }
                
        }
        return true
    }
    
    class func checkBoard(_ board:[[Int]]) -> Bool {
        
        //TODO assert size
        //TODO assert null
        
        
        
        print("--------------")
        for row in board {
            
            print(row)
        }
        print("--------------")
        return true
    }
    
    
}
