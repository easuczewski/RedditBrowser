//
//  Post.swift
//  RedditBrowser
//
//  Created by Edward Suczewski on 12/7/15.
//  Copyright © 2015 Edward Suczewski. All rights reserved.
//

import Foundation

struct Post {
    
    static let kTitle = "title"
    static let kUrl = "url"
    
    var title: String = ""
    var url: String = ""
    
    init(jsonDictionary: [String: AnyObject]) {
        if let title = jsonDictionary[Post.kTitle] as? String {
            self.title = title
        }
        if let url = jsonDictionary[Post.kUrl] as? String {
            self.url = url
        }
    }
    
    
}


