//
//  NetworkController.swift
//  RedditBrowser
//
//  Created by Edward Suczewski on 12/7/15.
//  Copyright © 2015 Edward Suczewski. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let baseURLString = "https://www.reddit.com/r/"
    
    static func getURLForSubreddit(subreddit: String) -> NSURL {
        let urlString = baseURLString + subreddit + ".json"
        return NSURL(string: urlString)!
    }
    
    static func dataAtURL(url: NSURL, completion: (resultData: NSData?) -> Void) {
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            }
            completion(resultData: data)
        }
        dataTask.resume()
    }
    
}