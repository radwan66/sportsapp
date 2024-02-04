//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by radwan on 31/01/20224.
//

import XCTest
@testable import SportsApp

final class SportsAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApiGenerk(){
        let expectaation = expectation(description: "waiting for the api")
        ApiManger.SharedApiManger.fetchLeagues(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=b145ab1293e571e3e658e1bf9592ee72b13c9ab09b385efba3b6aa3a8df39195", decodingModel: LeaguesModel.self) { Leages, error in
            guard let leages = Leages?.result else{
                XCTFail("nill")
                expectaation.fulfill()
                return
            }
            XCTAssertGreaterThan(leages.count, 0)
            expectaation.fulfill()
        }
        waitForExpectations(timeout: 5000)
    }
    
    
    func testAllLeagesVM(){
        var  Allleages = LeagesViewModel(url: SportsCategory.Football.Url, sport:SportsCategory.allCases[0].rawValue.lowercased() )
        let expectaation = expectation(description: "waiting for the api")
        Allleages.fetch { allLeages in
            guard let allLeages = allLeages else{
                XCTFail("nill")
                expectaation.fulfill()
                return
            }
            
            XCTAssertGreaterThan(allLeages.count, 0)
            
            expectaation.fulfill()
        }
        waitForExpectations(timeout: 5000)
    }
    
    func testLeagesDetailsVM(){
        var  leagesDetail = LeagesDetailsViewModel(id: 152, sport:SportsCategory.allCases[0].rawValue.lowercased() , LeageName: "Premier League", image: "https://apiv2.allsportsapi.com/logo/logo_leagues/28_world-cup.png")
        let expectaation = expectation(description: "waiting for the api")
        leagesDetail.fetch { LeagesDetail in
            guard let LeagesD = LeagesDetail else{
                XCTFail("nill")
                expectaation.fulfill()
                return
            }
            
            XCTAssertGreaterThan(LeagesD.count, 0)
            
            expectaation.fulfill()
        }
        waitForExpectations(timeout: 5000)
    }
    
    func testTeamDetails(){
        var  teamDetails = TeamDetailViewModel(id: 3094, sport:SportsCategory.allCases[0].rawValue.lowercased())
        
        let expectaation = expectation(description: "waiting for the api")
        teamDetails.FetchTeamDetails{ teamDetailss in
            guard let Team = teamDetailss else{
                XCTFail("nill")
                expectaation.fulfill()
                return
            }
            
            XCTAssertGreaterThan((Team.first?.players?.count)!, 0)

            expectaation.fulfill()
        }
        
        waitForExpectations(timeout: 5000)
    }
   
    
    
    // MARK: - CORE DATA TESTS
       
       func testSaveLeaguesCD(){
           let coreDataManager = CoreDataManger.sharedCoreManger
           let leagueName = "League"
           let sportName = "Sport"
           let leagueKey = 123
           let testImage = UIImage(named: "re")
           
           let result = coreDataManager.Save(leageName: leagueName, sportName: sportName, leageKey: Int32(leagueKey), Image: testImage)
           
           XCTAssertTrue(result.isSaved, "League should be saved successfully")
           XCTAssertNil(result.error, "No error should be returned")
           
           if let leagues = coreDataManager.fetchData().Leagues {
               for league in leagues {
                   if league.league_name == leagueName {
                       coreDataManager.deleteLeagueFromCoreData(league: league)
                   }
               }
           }
       }
    func testcoreData(){
        let result = CoreDataManger.sharedCoreManger.fetchData()
        
        guard let fav = result.Leagues else{
            XCTFail("nill")
            return
            
        }
        XCTAssert(fav.count >= 0)
        
    }
    
    func testcoreData2(){
        let result = CoreDataManger.sharedCoreManger.checkIfExixst(leageName: "  ")
        
        XCTAssert(result == false )
        
    }
    
    
   }
   
        
    

