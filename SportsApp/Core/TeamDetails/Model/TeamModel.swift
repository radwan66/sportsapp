//
//  TeamModel.swift
//  SportsApp
//
//  Created by radwan on 02/02/20224.
//

import Foundation
struct TeamModel: Codable {
    var success : Int?
    var result:[Result]



}
struct Result : Codable {
    var team_name: String?
    var team_logo: String?
    //for tennis
    var player_name :String?
    var player_logo : String?
    
    var players: [Player]?
    var coaches: [Coach]?
}
struct Coach: Codable {
    var coach_name: String?


}

struct Player: Codable {
    var player_name : String?
    var player_number :String?
    var player_age  : String?
    var player_rating:  String?
    var player_yellow_cards: String?
    var player_red_cards: String?
    var player_image :String?
}
