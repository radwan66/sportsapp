//
//  LeagesDetailsViewModel.swift
//  SportsApp
//
//  Created by radwan on 02/02/20224.
//

import Foundation
class LeagesDetailsViewModel  {
    var LeagesEvents: [upcommingEvents]?
    var latestEvents: [upcommingEvents]?
    var id : Int?
    var sport: String?
    var LeageName:String?
    var image :String?
    
    
   
    
    
    init(id: Int , sport: String,LeageName:String,image:String ) {
        self.id = id
        self.sport = sport
        self.LeageName = LeageName
        self.image =  image
        LeagesEvents = [upcommingEvents]()
    }
    var url : String{
        let date = getDates()
        if(self.sport)=="cricket"{
      
            return "https://apiv2.allsportsapi.com/\(sport ?? "football")?met=Fixtures&leagueId=\(id ?? 0)&from=from=\(date.CurrentData)&to=\(date.NextDate)&APIkey=\(ApiKey.apikey.rawValue)"
        }
        else if self.sport == "tennis" {
        return "https://apiv2.allsportsapi.com/\(sport ?? "football")/?met=Fixtures&leagueId=\(id ?? 0)&from=from=\(date.CurrentData)&to=\(date.NextDate)&APIkey=\(ApiKey.apikey.rawValue)"
            

        }
        else {
           return "https://apiv2.allsportsapi.com/\(sport ?? "football")?met=Fixtures&leagueId=\(id ?? 0)&from=\(date.CurrentData)&to=\(date.NextDate)&APIkey=\(ApiKey.apikey.rawValue)"
        }
    }
    
    func fetch(completionHandler: @escaping ([upcommingEvents]?) -> Void) {
        // Call the fetchLeagues function from ApiManger to fetch data from the API
        let date = getDates()
        ApiManger.SharedApiManger.fetchLeagues(url:"https://apiv2.allsportsapi.com/\(sport ?? "football")?met=Fixtures&leagueId=\(id ?? 0)&\(sport=="tennis" ? "from=" : sport=="cricket" ? "from=" :"")from=\(date.CurrentData)&to=\(date.NextDate)&APIkey=\(ApiKey.apikey.rawValue)", decodingModel: LeaguesDetailsModel.self) { data, error in
            // Handle the API response
            
            completionHandler(data?.result)
            self.LeagesEvents = data?.result
            print("Events:\(data)-\(self.id) -\(self.sport)")
        }
        
    }
    
    func fetchLatestEvents(completionHandler: @escaping ([upcommingEvents]?) -> Void) {
        // Call the fetchLeagues function from ApiManger to fetch data from the API
        let date = getDates()
        ApiManger.SharedApiManger.fetchLeagues(url:"https://apiv2.allsportsapi.com/\(sport ?? "football")?met=Fixtures&leagueId=\(id ?? 0)&\(sport=="tennis" ? "from=" : sport=="cricket" ? "from=" :"")from=\(date.PastDate)&to=\(date.yesterDay)&APIkey=\(ApiKey.apikey.rawValue)", decodingModel: LeaguesDetailsModel.self) { data, error in
            // Handle the API response
            
            completionHandler(data?.result)
            self.latestEvents = data?.result
            print("Events:\(data)-\(self.id) - \(self.sport)")
            // print("Events:\(data)")
        }
    }
    
    
    func getDates()->(CurrentData:String,PastDate:String,NextDate:String,yesterDay:String){
        let TodayDate = Date()
        let yesterDay = TodayDate.addingTimeInterval(TimeInterval(86400 * -1))
        let PastDate = TodayDate.addingTimeInterval(TimeInterval(86400 * -14))
        let nextDate = TodayDate.addingTimeInterval(TimeInterval(86400 * 14))
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let result = dateFormater.string(from: TodayDate)
        let result2 = dateFormater.string(from: PastDate)
        let result3 = dateFormater.string(from: nextDate)
        let result4 = dateFormater.string(from: yesterDay)
        print(result)
        print(result2)
        print(result3)
        print(result4)
        return(result,result2,result3,result4)
    }
}
