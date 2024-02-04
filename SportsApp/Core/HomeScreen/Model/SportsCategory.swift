//
//  SportsCategory.swift
//  SportsApp
//
//  Created by radwan on 01/02/20224.
//

import Foundation
enum SportsCategory :String, CaseIterable {
    case Football = "Football"
    case BasketBall = "BasketBall"
    case Cricket  = "Cricket"
    case Tennis  = "Tennis"
    
    var Url :String {
        switch self {
        case .Football: return "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(ApiKey.apikey.rawValue)"
        case .BasketBall: return "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=\(ApiKey.apikey.rawValue)"
        case .Cricket: return "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=\(ApiKey.apikey.rawValue)"
        case .Tennis: return "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=\(ApiKey.apikey.rawValue)"
            
        }
    }

    var Image:String  {
        switch self {
        case .Football: return "FootBall"
        case .BasketBall: return "BasketBall"
        case .Cricket: return "Cricket"
        case .Tennis: return "Tennis"
            
        }
    }
    
}


enum ApiKey :String {
    case apikey = "b145ab1293e571e3e658e1bf9592ee72b13c9ab09b385efba3b6aa3a8df39195"
    
    
}
