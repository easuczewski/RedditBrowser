//
//  ViewController.swift
//  RedditBrowser
//
//  Created by Edward Suczewski on 12/7/15.
//  Copyright © 2015 Edward Suczewski. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var subredditTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func searchButtonTapped(sender: UIButton) {
        if subredditTextField.text != "" {
            if let subreddit = subredditTextField.text {
                PostController.sharedInstance.searchForPostsAtSubreddit(subreddit, completion: { (success, posts) -> Void in
                        if success {
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            PostController.sharedInstance.posts = posts
                            self.tableView.reloadData()
                            })
                        }
                })
            }
        }
        self.tableView.reloadData()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func noResultsAlert() {
        let alert = UIAlertController(title: "Search Failed", message: "The subreddit you entered does not exists", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.sharedInstance.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath)
        
        let post = PostController.sharedInstance.posts[indexPath.row]
        cell.textLabel?.text = post.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = PostController.sharedInstance.posts[indexPath.row]
        if let url = NSURL(string: post.url) {
            let vc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
            presentViewController(vc, animated: true, completion: nil)
        }
//  To open page in a separate Safari window, the code below is an option:
//        UIApplication.sharedApplication().openURL(url!)
    }

}

