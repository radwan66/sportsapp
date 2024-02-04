//
//  TeamMembersCell.swift
//  SportsApp
//
//  Created by radwan on 02/02/20224.
//

import UIKit

class TeamMembersCell: UICollectionViewCell {
    var cornerRadius: CGFloat = 11.0
    @IBOutlet weak var PlayerName: UILabel!
    @IBOutlet weak var PlayerAge: UILabel!
    @IBOutlet weak var PlayerImage: UIImageView!
    
    @IBOutlet weak var card2label: UIImageView!
    @IBOutlet weak var card1label: UIImageView!
    @IBOutlet weak var teshirtnumber: UILabel!
    @IBOutlet weak var AgeLabel: UILabel!
    
    @IBOutlet weak var PlayerRedCards: UILabel!
    @IBOutlet weak var PlayerYelloCards: UILabel!
    @IBOutlet weak var PlayerNumber: UILabel!
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
        
      
        PlayerImage.layer.cornerRadius = PlayerImage.bounds.width/2
        PlayerImage.clipsToBounds = true
       
        
    }

}
