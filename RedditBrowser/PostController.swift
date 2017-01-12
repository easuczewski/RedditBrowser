//
//  PostController.swift
//  RedditBrowser
//
//  Created by Edward Suczewski on 12/7/15.
//  Copyright © 2015 Edward Suczewski. All rights reserved.
//

import Foundation

class PostController {
    
    static let sharedInstance = PostController()
    
    var posts: [Post] = []
    
    func searchForPostsAtSubreddit(subreddit: String, completion: (success: Bool, posts: [Post]) -> Void) {
        
        posts = []
        
        var internalPosts: [Post] = []
        
        let url = NetworkController.getURLForSubreddit(subreddit)
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            guard let resultData = resultData else {
                completion(success: false, posts: [])
                return
            }
            
            do {
                let resultsAnyObject = try NSJSONSerialization.JSONObjectWithData(resultData, options: .AllowFragments)
                
                if let dictionary = resultsAnyObject as? [String: AnyObject] {
                    if let dataDictionary = dictionary["data"] as? [String: AnyObject] {
                        if let childrenArray = dataDictionary["children"] as? [[String: AnyObject]] {
                            for dictionary in childrenArray {
                                if let postDictionary = dictionary["data"] as? [String: AnyObject] {
                                    let post = Post(jsonDictionary: postDictionary)
                                    internalPosts.append(post)
                                    completion(success: true, posts: internalPosts)
                                }
                            }
                        }
                    }
                }
                
  
            } catch {
                completion(success: false, posts: [])
            }
        }
    }
}

        
        