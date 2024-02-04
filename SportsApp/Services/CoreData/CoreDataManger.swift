//
//  CoreDataManger.swift
//  SportsApp
//
//  Created by radwan on 31/01/20224.
//

import Foundation
import CoreData
import UIKit
class CoreDataManger{
   
    
    
   static let sharedCoreManger = CoreDataManger()
    
    // Function to Save a league to Core Data
    func Save (leageName:String? ,sportName:String? ,leageKey:Int32?,Image:UIImage?)->(isSaved:Bool,error:Error?){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               print("Error: Unable to access AppDelegate")
            return(false,coreDataError.appdelelgate)
           }

           let context = appDelegate.persistentContainer.viewContext

           guard let entity = NSEntityDescription.entity(forEntityName: "Leaguess", in: context) else {
               print("Error: Entity 'Leaguess' not found in Core Data model.")
               return(false,coreDataError.CoreDataNotfound)
           }

           guard let favoriteLabel = leageName, !favoriteLabel.isEmpty else {
               print("Error: Please enter a valid league name.")
               return (false,coreDataError.LeageNameEmpty)
           }
        guard let LeageKey = leageKey else{return (false,coreDataError.LeageKeyEmpty)}
        
    
        
        // convert image to data
           guard let image = Image else {
               print("Error: Unable to retrieve the image URL.")
               return (false,coreDataError.image)
           }
        
            let DataImage = image.pngData()

        
     

        
           // Check if the league with the same name already exists in Core Data
           let fetchRequest: NSFetchRequest<Leaguess> = Leaguess.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "league_name == %@", favoriteLabel)

           do {
               let existingLeagues = try context.fetch(fetchRequest)
               if let existingLeague = existingLeagues.first {
                   print("League already exists with the name: \(existingLeague.league_name ?? "")")
//                   FavoriteImage.image = UIImage(named: "heart.fill")

                   return(false,nil)
               }
           } catch {
               print("Error fetching existing leagues: \(error.localizedDescription)")
               return(false,coreDataError.CoreDataNotfound)
           }

        
        
        
        
        
           let newLeague = Leaguess(entity: entity, insertInto: context)

           newLeague.league_name = favoriteLabel
          newLeague.league_logo = DataImage
       
           newLeague.league_key = Int32(LeageKey)

        // newLeague.league_logo = favoriteImageURLString
            newLeague.league_sportName = sportName
           do {
               try context.save()
               print("League saved successfully.")
            return(true,nil)
               

           } catch {
              
               print("Error saving: \(error.localizedDescription)")
               return(false,coreDataError.CoreDataNotfound)
           }
        
        
    }
    
    // Function to delete a league from Core Data
     func deleteLeagueFromCoreData(league: Leaguess) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        context.delete(league)

        do {
            try context.save()
            print("League deleted successfully from Core Data.")
        } catch {
            print("Error deleting league: \(error.localizedDescription)")
        }
    }
    
  
    

    // MARK: - Fetch Data Function
    func fetchData()->(Leagues:[Leaguess]?,error:Error?){
        var leagues:[Leaguess]=[]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Leaguess> = Leaguess.fetchRequest()

        do {
            leagues = try context.fetch(fetchRequest)
            return (leagues,nil)
            // Reload the table view data on the main thread
           /* DispatchQueue.main.async {
                self.FavoriteTableView.reloadData()
            }*/
            
        } catch {
            
            print("Error fetching data: \(error.localizedDescription)")
            return(nil,coreDataError.CoreDataNotfound)
        }
    }
    
    
    
    
    
    func checkIfExixst(leageName:String)->Bool?{
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
             
        let context = appDelegate!.persistentContainer.viewContext
       
        let fetchRequest: NSFetchRequest<Leaguess> = Leaguess.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "league_name == %@", leageName)

        do {
            let existingLeagues = try context.fetch(fetchRequest)
            if let existingLeague = existingLeagues.first {
                print("League already exists with the name: \(existingLeague.league_name ?? "")")
//                   FavoriteImage.image = UIImage(named: "heart.fill")
                
                return(true)
            }
            else{
                return(false)
            }
        } catch {
            print("Error fetching existing leagues: \(error.localizedDescription)")
            return nil
        }
        
        
    }
    
}


enum coreDataError :Error,LocalizedError{
    case appdelelgate
    case CoreDataNotfound
    case LeageNameEmpty
    case LeageKeyEmpty
    case image
    
    
    var description :String {
        switch self{
        case .appdelelgate : return "Error: Unable to access AppDelegate"
        case.CoreDataNotfound: return "Error: Entity 'Leaguess' not found in Core Data model."
        case.LeageNameEmpty: return "Error: Leage Name is empty "
        case.LeageKeyEmpty: return "Error: Leage Key is empty"
        case.image : return "image Is Empty"
        }
    }
    
    
    
}
