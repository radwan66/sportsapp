//
//  FavoriteCell.swift
//  SportsApp
//
//  Created by radwan on 01/02/20224.
//

import UIKit
import Kingfisher
import CoreData

class FavoriteCell: UITableViewCell {
    @IBOutlet weak var FavoriteImage: UIImageView!
    @IBOutlet weak var FavoriteLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
   
    var sportName: String?
    var leagueKey: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
       
        FavoriteImage.layer.borderWidth = 1
        FavoriteImage.layer.masksToBounds = false
        FavoriteImage.layer.borderColor = UIColor.white.cgColor
        FavoriteImage.layer.cornerRadius = FavoriteImage.frame.height/2
        FavoriteImage.clipsToBounds = true
       
       
    }

    
  
    
    func configure(sportName: String?, leagueKey: Int?) {
        self.sportName = sportName
        self.leagueKey = leagueKey
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        let result =  CoreDataManger.sharedCoreManger.Save(leageName: FavoriteLabel.text, sportName: sportName, leageKey: Int32(leagueKey!),Image: self.FavoriteImage.image)
        if result.error != nil {
            // Show an alert that the league already exists
            let alertController = UIAlertController(title: "Error", message: result.error?.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        else{
            if(result.isSaved){
                // Show an alert to indicate success
                let alertController = UIAlertController(title: "Success", message: " successfully added.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                favoriteButton.tintColor = UIColor.red
            }
            else{
                // Show an alert that the league already exists
                let alertController = UIAlertController(title: "League Exists", message: "The Leages allready Exist", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    
}
