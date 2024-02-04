//
//  IncomingCell.swift
//  ProjectCollectionn
//
//  Created by radwan on 02/02/20224.
//

import UIKit

class IncomingCell: UICollectionViewCell {

    @IBOutlet weak var BackgroundImage: UIImageView!
    
    @IBOutlet weak var matchTime: UILabel!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var HomeTeamLogo:UIImageView!
    
    @IBOutlet weak var LatestDate: UILabel!
    @IBOutlet weak var LatestTime: UILabel!
    @IBOutlet weak var HomeTeamName: UILabel!
    
    @IBOutlet weak var AwayTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        BackgroundImage.backgroundColor = .black
        

    }

}
