//
//  TeamDetailMV.swift
//  SportsApp
//
//  Created by radwan on 02/02/20224.
//

import Foundation
class TeamDetailViewModel{
   
    var id : Int?
    var sport: String?
    var TeamData : [Result]?
    
    init(id: Int , sport: String ) {
        self.id = id
        self.sport = sport
        
      
        TeamData = [Result]()
    }
    
 
   
    func FetchTeamDetails(completionHandler: @escaping ([Result]?) -> Void) {
        // Call the fetchLeagues function from ApiManger to fetch data from the API
      
        ApiManger.SharedApiManger.fetchLeagues(url:"https://apiv2.allsportsapi.com/\(sport ?? "football")/?&met=Teams&teamId=\(id ?? 0)&APIkey=\(ApiKey.apikey.rawValue)", decodingModel: TeamModel.self) { data, error in
            // Handle the API response
          
            completionHandler(data?.result)
            self.TeamData = data?.result
          
            print("ID:\(self.id)")
        }
    }
    

    
}

