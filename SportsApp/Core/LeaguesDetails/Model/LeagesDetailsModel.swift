//
//  LeagesDetailsViewModel.swift
//  SportsApp
//
//  Created by radwan on 02/02/20224.
//

import Foundation

struct LeaguesDetailsModel : Codable{
    var success : Int?
    var result : [upcommingEvents]
    
}
struct upcommingEvents : Codable{
    var event_home_team :String?
    var event_away_team :String?
    var home_team_key :Int?
    var away_team_key : Int?
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    var event_status : String?
    var home_team_logo :String?
    var away_team_logo  :String?
    
    var event_date  :String?
    var event_time: String?
    var league_logo : String?
    var event_final_result : String?
    var event_first_player : String?
    var event_second_player: String?
    var first_player_key: Int?
    var second_player_key :Int?
    var event_first_player_logo:String?
    var event_second_player_logo:String?
    
}
