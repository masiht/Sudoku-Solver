//
//  ViewController.swift
//  Sudoku Solver
//
//  Created by Masih Tabrizi on 4/28/17.
//  Copyright © 2017 Tabrizi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var solveButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "cell"
    var puzzleNums : [[Int]] = [
        [5,3,0,0,7,0,0,0,0],
        [6,0,0,1,9,5,0,0,0],
        [0,9,8,0,0,0,0,6,0],
        [8,0,0,0,6,0,0,0,3],
        [4,0,0,8,0,3,0,0,1],
        [7,0,0,0,2,0,0,0,6],
        [0,6,0,0,0,0,2,8,0],
        [0,0,0,4,1,9,0,0,5],
        [0,0,0,0,8,0,0,7,9]
    ]
    
    let puzzle = Board()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearButton.addTarget(self, action: #selector(self.clearBoard),
                              for: UIControlEvents.touchUpInside)
        
        solveButton.addTarget(self, action: #selector(self.solve),
                              for: UIControlEvents.touchUpInside)
        
        // FIXME: TEMP
        puzzle.board = puzzleNums
//        puzzle.solve()
        puzzle.toString()
        
    }

    // MARK: - UI IBActions
    
    func clearBoard() {
        
//        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity: 4, options: [], animations: {
//            sender.transform = CGAffineTransform(scaleX: 1.025, y: 1.1)
//            
//        }, completion: nil)
//        
//        UIView.animate(withDuration: 0.2, delay: 0.3, usingSpringWithDamping: 2, initialSpringVelocity: 10, options: [], animations: {
//            sender.transform = CGAffineTransform.identity
//            
//        }, completion: nil)
        
        if (puzzle.clearBoard()) {
        
            // TODO: better representation of the success is required
            self.collectionView.reloadData()
            print("Board Cleared")
            
        }
        
        
        
    }
    
    func solve() {
        
//        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity: 4, options: [], animations: {
//            sender.transform = CGAffineTransform(scaleX: 1.025, y: 1.1)
//            
//        }, completion: nil)
//        
//        UIView.animate(withDuration: 0.2, delay: 0.3, usingSpringWithDamping: 2, initialSpringVelocity: 10, options: [], animations: {
//            sender.transform = CGAffineTransform.identity
//            
//        }, completion: nil)
        
        
        if (puzzle.solve()) {
            
            // FIXME: better representation of the success is required
            self.collectionView.reloadData()
            print("Board solved")
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        // FIXME
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        collectionView.addBackground("Sudoku.png")
        return CGSize(width: width/13, height: height/9)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SudokuCollectionViewCell
        
        cell.myLabel.backgroundColor = UIColor.white
        
        let number = puzzle.board[indexPath.section][indexPath.row]
        
        if number > 0 {
            
            cell.myLabel.text = String(number)
        
        } else {
            
            cell.myLabel.text = ""
        }
        
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell at [\(indexPath.section), \(indexPath.item)]")
        
        print(((collectionView.cellForItem(at: indexPath) as? SudokuCollectionViewCell)?.myLabel!.text)!)
        
    }
}


extension UIView {
    
    func addBackground(_ imageName : NSString) {
        
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: imageName as String)
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }}

