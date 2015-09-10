//
//  Request.swift
//  DotaApi
//
//  Created by lunner on 9/4/15.
//  Copyright (c) 2015 lunner. All rights reserved.
//

import Foundation

class Request {
	static var queue: NSOperationQueue? 
	
	static func get(#url: String, params: [String: String]?) -> RequestResult {
		var paramString: NSMutableString = NSMutableString(string: "?")
		//let keys = params.allKeys
//		for(var key in keys) {
		if let params = params {
			for (key, value) in params {
				paramString.appendFormat("%@=%@&", key, value)
			}

		}
		let requestURL = "\(url)\(paramString.substringToIndex(paramString.length-1))"
		
		var request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: requestURL)!, cachePolicy:  NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
		request.HTTPMethod = "GET"
		
		var response: NSURLResponse?
		var result = RequestResult()
		let resp = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &result.error)
		let httpResponse = response as? NSHTTPURLResponse
		result.statusCode = httpResponse?.statusCode
		result.resultData = resp
		return result
	}
	
	static func queuedGet(url: String, params: [String: String]?, completionHandler: ((NSURLResponse!, NSData!, NSError!) -> Void)?) ->RequestResult?  {
		var paramString: NSMutableString = NSMutableString(string: "?")
		//let keys = params.allKeys
		//		for(var key in keys) {
		if let params = params {
			for (key, value) in params {
				paramString.appendFormat("%@=%@&", key, value)
			}
			
		}
		let requestURL = "\(url)\(paramString.substringToIndex(paramString.length-1))"
		var request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: requestURL)!, cachePolicy:  NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
		request.HTTPMethod = "GET"
		
		if self.queue == nil {
			queue = NSOperationQueue()
		}
		if completionHandler != nil {
			NSURLConnection.sendAsynchronousRequest(request, queue: queue!, completionHandler: completionHandler!)
			return nil
		} else {
			var result: RequestResult? = nil

			NSURLConnection.sendAsynchronousRequest(request, queue: queue!, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) in
				result = RequestResult()
				result!.error = error
				let resp = response as! NSHTTPURLResponse
				result!.statusCode = resp.statusCode
				result!.resultData = data
			})
			return result
		}
		
	
	}
		
		
		
		
}