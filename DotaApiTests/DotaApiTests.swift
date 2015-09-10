//
//  DotaApiTests.swift
//  DotaApiTests
//
//  Created by lunner on 9/4/15.
//  Copyright (c) 2015 lunner. All rights reserved.
//

import UIKit
import XCTest

class DotaApiTests: XCTestCase {
	var dotaApi: DotaApi? = nil
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		dotaApi = DotaApi(apiKey: "7CFACD5BD037C2FCD0D4DE5EE1BBD877", language: "zh_CN", format: "json")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		dotaApi = nil
    }
    // MARK: Dota 2
	func testGetMatchHistory() {
		let accountID = "130490570"
		let result = dotaApi!.getMatchHistory(accountID: accountID)
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
		
	}
	
	func testGetMatchHistoryBySeqNum() {
		
		let result = dotaApi!.getMatchHistoryBySeqNum(seqNum: "1562913727", matchesRequested: 10)
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
	}
	
	func testGetMatchDetails() {
		let result = dotaApi!.getMatchDetails(matchID: "1756220530")
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)

	}
	
	func testGetLeagueListing() {
		let result = dotaApi!.getLeagueListing()
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)

	}
	
	func testGetLiveLeagueGames() {
		let result = dotaApi!.getLiveLeagueGames()
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)

	}
	
	func testGetScheduledLeagueGames() {
		let interval = 3600.0*24*7
		let dateBefore = NSDate(timeIntervalSinceNow: -interval)
		let dateAfter = NSDate(timeIntervalSinceNow: interval)
		let dateMin = UInt32(dateBefore.timeIntervalSince1970)
		let dateMax = UInt32(dateAfter.timeIntervalSince1970)
		let result = dotaApi!.getScheduledLeagueGames(dateMin: dateMin, dateMax: dateMax)
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)

	}
	
	func testGetTeamInfoByTeamID() {
		let result = dotaApi?.getTeamInfoByTeamID(startAtTeamID: "1059819", teamsRequested: 10)
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
	}
	
	func testGetTournamentPlayerStats() {
		let result = dotaApi?.getTournamentPlayerStats(accountID: "110097001")
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
	}
	// MARK: IDOTA2_<ID>
	func testGetRarities() {
		let result = dotaApi?.getRarities()
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
	}
	
	func testGetGameItems() {
		let result = dotaApi?.getGameItems()
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
	}
	
	func testGetHeros() {
		let result = dotaApi!.getHeroes()
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
	}
	
	func testGetTournamentPrizePool() {
		let result = dotaApi!.getTournamentPrizePool(leagueID: "1212")
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)

	}
	
	// MARK: ISteamUser
	func testGetFriendList() {
		let steamID = LUUtils.convertTo64Bit(130490570)
		let result = dotaApi?.getFriendList(steamID: steamID.description)
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
		

	}
	
	func testGetPlayerBans() {
		let steamIDs = String(format: "%@,%@", LUUtils.convertTo64Bit(130490570).description, LUUtils.convertTo64Bit(110097001).description)
		let result = dotaApi?.getPlayerBans(steamIDs: steamIDs)
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)

	}
	
	func testGetPlayerSummaries() {
		let result = dotaApi?.getPlayerSummaries(steamIDs:  LUUtils.convertTo64Bit(130490570).description)
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)
	}
	func testGetUserGroupList() {
		let result = dotaApi?.getUserGroupList(steamID: LUUtils.convertTo64Bit(130490570).description)
		XCTAssertNotNil(result, "result should not be nil")
		XCTAssertTrue(result?.statusCode! == 200, "statusCode should = 200")
		XCTAssertNotNil(result?.resultData, "resultData should not be nil")
		println(result?.dataToDictionary()?.description)

	}
	
	func testGetResolveVanityURL() {
		// TODO: test GetResolveVanityURL
	}
	
	// MARK: test update heros and items
	func testUpdateHeros() {
		/*
		let result = getHeroes(language: language)
		if result == nil {
			return
		}
		var filename: String
		if language != nil {
			filename = "heros_\(language).json"
		} else {
			filename = "heros_\(self.language).json"
		}
		LUUtils.saveToJSONFile(result!.dataToDictionary()!, filename: filename)
		*/
		
		dotaApi!.updateHeros()
		let filename = "heros_\(dotaApi!.language).json"
		let documentsURL = LUUtils.applicationDocumentsDirectory().URLByAppendingPathComponent("json", isDirectory: true)
		let storeURL = documentsURL.URLByAppendingPathComponent(filename)
		let dictionary = NSDictionary(contentsOfURL: storeURL)!
		let count = dictionary["count"] as! NSString
		//XCTAssertNotNil(count, "count should not be nil")
		XCTAssertTrue(count == "110", "count should be 110")
	}
    func testExample() {
        // This is an example of a functional test case.
		println("\(Int32(2).description)")
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
			[unowned self] in
            // Put the code you want to measure the time of here.
			let accountID = "130490570"
			let result = self.dotaApi!.getMatchHistory(accountID: accountID)
        }
    }
    
}
