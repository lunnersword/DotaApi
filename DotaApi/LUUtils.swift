//
//  Parse.swift
//  DotaApi
//
//  Created by lunner on 9/6/15.
//  Copyright (c) 2015 lunner. All rights reserved.
//

import Foundation

class LUUtils: NSObject {
	
	static func applicationDocumentsDirectory() -> NSURL {
		let fileManager = NSFileManager.defaultManager()
		
		let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as! [NSURL]
		return urls[0]
	}
	
	static func convertTo64Bit(id: Int32) -> Int64 {
		return Int64(id) + 76561197960265728
	}
	
	static func convertTo32Bit(id: Int64) -> Int32 {
		return Int32(id - 76561197960265728)
	}
	static func loadFromJSONFile(filename: String) -> NSDictionary? {
		let documentsURL = applicationDocumentsDirectory().URLByAppendingPathComponent("json", isDirectory: true)
		let storeURL = documentsURL.URLByAppendingPathComponent(filename)
		let inputStream = NSInputStream(URL: storeURL)
		var error: NSError?
		inputStream?.open()
		let result = NSJSONSerialization.JSONObjectWithStream(inputStream!, options: nil, error: &error) as? NSDictionary
		inputStream?.close()
		return result
	}
	static func saveToJSONFile(jsonDict: NSDictionary, filename: String) {
		let documentsURL = applicationDocumentsDirectory().URLByAppendingPathComponent("json", isDirectory: true)
		let storeURL = documentsURL.URLByAppendingPathComponent(filename)
		let outputStream = NSOutputStream(URL: storeURL, append: false)!
		outputStream.open()
		var error: NSError?
		let num = NSJSONSerialization.writeJSONObject(jsonDict, toStream: outputStream, options: nil, error: &error)
		if num == 0 {
			println("\(error?.localizedDescription)")
		}
		outputStream.close()
	}
}