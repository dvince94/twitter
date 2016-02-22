//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Vincent Duong on 2/20/16.
//  Copyright © 2016 Vincent Duong. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets: [Tweet]!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweet = tweets {
            return tweet.count
        }
        else {
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
        let tweet = tweets[indexPath.row]
        //Set the tweet text
        if let tweetText = tweet.text as? String {
            cell.tweetLabel.text = tweetText
        }
        //Set the time stamp
        cell.timeStampLabel.text = tweet.timestamp!
        cell.userName.text = tweet.screenName!
        if let profileImg = tweet.profileImageURL {
            cell.profileImage.setImageWithURL(profileImg)
        }
        else {
            //Default image
            cell.profileImage.image = UIImage(named: "Twitter_logo_blue_48")
        }
        cell.retweetCountLabel.text = "\(tweet.retweetCount)"
        cell.favoritedCountLabel.text = "\(tweet.favoriteCount)"
        
        cell.tweetID = tweet.tweetID!
        cell.retweeted = tweet.retweeted!
        cell.favorited = tweet.favorited!
        cell.tweets = tweet
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
