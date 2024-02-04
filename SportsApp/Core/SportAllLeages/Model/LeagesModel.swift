//
//  LeagesModel.swift
//  SportsApp
//
//  Created by radwan on 01/02/20224.
//

import Foundation


struct LeaguesModel : Codable{
    var success : Int?
    var result : [Leagues]
    
}
struct Leagues : Codable{
    var league_key :Int?
    var league_name :String?
    var country_key : Int?
    var country_name :String?
    var league_logo  :String?
    var country_logo  :String?
    var youtubeURL: String?
    var sportName: String?
}
