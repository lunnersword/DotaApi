//
//  DotaApi.swift
//  DotaApi
//
//  Created by lunner on 9/4/15.
//  Copyright (c) 2015 lunner. All rights reserved.
//

import Foundation

class DotaApi {
	var apiKey: String
	var language: String
	var format: String 
	init(apiKey: String, language: String? = nil, format: String? = nil) {
		self.apiKey = apiKey 
		if language == nil {
			self.language = "ch_CN"
		} else {
			self.language = language!
		}
		if format == nil {
			self.format = "json"
		} else {
			let xml = "xml"
			let json = "json"
			let vdf = "vdf"
			if !(format! as NSString).isEqualToString(xml) && !(format! as NSString).isEqualToString(json) && !(format! as NSString).isEqualToString(vdf) {
				self.format = "json"
			} else {
				self.format = format!
			}
		}
	}
	// MARK: Dota 2
	func getMatchHistory(accountID: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if accountID != nil {
			kwargs["account_id"] = accountID
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetMatchHistory.rawValue), params: kwargs)
		
		if result.statusCode != 200 {
			return nil
		} else {
			return result
		}
		
	}
	
	func getMatchHistoryBySeqNum(seqNum: String? = nil, matchesRequested: UInt32? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if seqNum != nil {
			kwargs["start_at_match_seq_num"] = seqNum
		}
		if matchesRequested != nil {
			kwargs["matches_requested"] = matchesRequested!.description
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetMatchHistoryBySeqNum.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil
		} else {
			return result
		}
	}
	
	func getMatchDetails(matchID: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if matchID != nil {
			kwargs["match_id"] = matchID
		}
		if kwargs["match_id"] == nil {
			return nil
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetMatchDetails.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil
		} else {
			return result
		}
		
	}
	
	func getLeagueListing(language: String? = nil, var kwargs: [String: String] = [String:String]()) -> RequestResult? {
		if language != nil {
			kwargs["language"] = language
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetLeagueListing.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}
	}
	
	func getLiveLeagueGames(var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetLiveLeagueGames.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}

	}
	
	func getTeamInfoByTeamID(startAtTeamID: String? = nil, teamsRequested: UInt32? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if startAtTeamID != nil {
			kwargs["start_at_team_id"] = startAtTeamID
		}
		if teamsRequested != nil {
			kwargs["teams_requested"] = teamsRequested!.description
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetTeamInfoByTeamID.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}

	}
	
	func getScheduledLeagueGames(dateMin: UInt32? = nil, dateMax: UInt32? = nil,var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		//var kwargs: [String: String] = [String: String]()
		if dateMin != nil {
			kwargs["date_min"] = dateMin!.description
		} 
		if dateMax != nil {
			kwargs["date_max"] = dateMax!.description
		}
		
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetScheduledLeagueGames.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}
	}
	
	func getTournamentPlayerStats(accountID: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if accountID != nil {
			kwargs["account_id"] = accountID
		}
		if kwargs["account_id"] == nil {
			return nil
		}
		
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetTournamentPlayerStats.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}

	}
	
	
	// MARK: ISteamUser
	func getFriendList(steamID: String? = nil, relationShip: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if steamID != nil {
			kwargs["steamid"] = steamID
		}
		if relationShip != nil {
			kwargs["relationship"] = relationShip
		}
		if kwargs["steamid"] == nil {
			return nil
		}
		if kwargs["relationship"] == nil {
			kwargs["relationship"] = "friend"
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetFriendList.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}
	}
	
	func getPlayerBans(steamIDs: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		//Comma-delimited list of SteamIDs
		if steamIDs != nil {
			kwargs["steamids"] = steamIDs
		}
		if kwargs["steamids"] == nil {
			return nil
		}
		
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetPlayerBans.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}

	}
	
	func getPlayerSummaries(steamIDs: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		//Comma-delimited list of SteamIDs
		if steamIDs != nil {
			kwargs["steamids"] = steamIDs
		}
		if kwargs["steamids"] == nil {
			return nil
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetPlayerSummaries.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}

	}
	
	func getUserGroupList(steamID: String? = nil, var kwargs: [String: String] = [String: String]() ) -> RequestResult? {
		if steamID != nil {
			kwargs["steamid"] = steamID
		}
		if kwargs["steamid"] == nil {
			return nil
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetUserGroupList.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}

	}
	
	func resolveVanityURL(vanityURL: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if vanityURL != nil {
			kwargs["vanityurl"] = vanityURL
		}
		if kwargs["vanityurl"] == nil {
			return nil
		}
		kwargs["key"] = self.apiKey
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.ResolveVanityURL.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}

	}
	//End ISteamUser
	
	// MARK: IDOTA2_<ID>
	func getRarities(var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetRarities.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}
	}
	
	func getHeroes(language: String? = nil, itemizedOnly: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if language != nil {
			kwargs["language"] = language
		}
		if itemizedOnly != nil {
			kwargs["itemizedonly"] = itemizedOnly
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetHeros.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}
	}
	
	func getGameItems(language: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if language != nil {
			kwargs["language"] = language
		}
		adjustQuearyParams(params: &kwargs)
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetGameItems.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}
	}
	
	func getTournamentPrizePool(leagueID: String? = nil, var kwargs: [String: String] = [String: String]()) -> RequestResult? {
		if leagueID != nil {
			kwargs["leagueid"] = leagueID
		}
		let result = Request.get(url: String(format: "%@%@", DotaURLs.BaseURL.rawValue, DotaURLs.GetTournamentPrizePool.rawValue), params: kwargs)
		if result.statusCode != 200 {
			return nil 
		} else {
			return result
		}
	}
	// End IDOTA2_<ID>
	// MARK: update items and heros, test fails
	
	func updateGameItems(language: String? = nil) {
		let result = getGameItems(language: language)
		if result == nil {
			return
		}
		var filename: String
		if language != nil {
			filename = "items_\(language).json"
		} else {
			filename = "items_\(language).json"
		}
		LUUtils.saveToJSONFile(result!.dataToDictionary()!, filename: filename)
	}
	
	func loadGameItems(language: String? = nil) -> NSDictionary? {
		var filename: String
		if language != nil {
			filename = "items_\(language).json"
		} else {
			filename = "items_\(language).json"
		}
		return LUUtils.loadFromJSONFile(filename)
	}
	
	func updateHeros(language: String? = nil) {
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
	}
	
	func loadHeros(language: String? = nil) -> NSDictionary? {
		var filename: String
		if language != nil {
			filename = "heros_\(language).json"
		} else {
			filename = "heros_\(self.language).json"
		}
		return LUUtils.loadFromJSONFile(filename)

	}

	
	func adjustQuearyParams(inout #params: [String: String])  {
		params[CommonParams.Key.rawValue] = self.apiKey
		if params[CommonParams.Language.rawValue] == nil {
			params[CommonParams.Language.rawValue] = self.language
		}
		if params[CommonParams.Format.rawValue] == nil {
			params[CommonParams.Format.rawValue] = self.format
		}
		
	}
	
	
	
}