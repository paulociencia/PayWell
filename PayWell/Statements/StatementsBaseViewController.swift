//
//  StatementsBaseViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit

class StatementsBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension StatementsBaseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:StatementsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "statementCell", for: indexPath) as! StatementsCollectionViewCell
        
        return self.populateCollectionCell(cell: cell, indexPath: indexPath)
    }
    
    func populateCollectionCell(cell: StatementsCollectionViewCell, indexPath: IndexPath) -> StatementsCollectionViewCell {
        return StatementsCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect: CGRect = UIScreen.main.bounds
        let screenWidth: CGFloat = screenRect.size.width
        let cellWidth = Float((screenWidth / 2.0))
        //Replace the divisor with the column count requirement. Make sure to have it in float.
        let size = CGSize(width: CGFloat(cellWidth - 15.0), height: CGFloat(100))
        
        return size
    }
}


