//
//  LeagesViewModel.swift
//  SportsApp
//
//  Created by radwan on 01/02/20224.
//
//


import Foundation

class LeagesViewModel {
    var LeagesResult: [Leagues]?
    var url : String?
    var sport: String?
    
    init(url: String , sport: String) {
        self.url = url
        self.sport = sport
        LeagesResult = [Leagues]()
    }

    func fetch(completionHandler: @escaping ([Leagues]?) -> Void) {
        // Call the fetchLeagues function from ApiManger to fetch data from the API
        ApiManger.SharedApiManger.fetchLeagues(url: url ?? "" , decodingModel: LeaguesModel.self) { data, error in
            // Handle the API response
            completionHandler(data?.result)
            self.LeagesResult = data?.result
        }
    }
}
