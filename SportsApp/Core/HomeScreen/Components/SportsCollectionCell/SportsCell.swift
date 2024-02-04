//
//  SportsCell.swift
//  SportsApp
//
//  Created by radwan on 01/02/20224.
//

import UIKit

class SportsCell: UICollectionViewCell {
    var cornerRadius: CGFloat = 11.0
    @IBOutlet weak var CellLabel: UILabel!
    
    @IBOutlet weak var CellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = cornerRadius
               contentView.layer.masksToBounds = true
               
               
               layer.cornerRadius = cornerRadius
               layer.masksToBounds = false
               
               // Apply a shadow
               layer.shadowRadius = 8.0
               layer.shadowOpacity = 0.10
               layer.shadowColor = UIColor.black.cgColor
               layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
}
