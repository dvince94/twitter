//
//  Tweet.swift
//  Twitter
//
//  Created by Vincent Duong on 2/16/16.
//  Copyright © 2016 Vincent Duong. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var timestamp: String?
    var screenName: String?
    var profileImageURL: NSURL?
    var tweetID: String?
    var favorited: Bool?
    var retweeted: Bool?
    
    init(dictionary:NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as! Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as! Int) ?? 0
        screenName = dictionary["user"]!["screen_name"] as? String
        tweetID = dictionary["id_str"] as? String
        let profileURL = dictionary["user"]!["profile_image_url"] as? String
        if let profileURL = profileURL {
            profileImageURL = NSURL(string: profileURL)
        }
        favorited = dictionary["favorited"] as? Bool
        retweeted = dictionary["retweeted"] as? Bool
        
        //Date formatting
        let createdAtString = dictionary["created_at"] as? String
        
        if let createdAtString = createdAtString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            let date = formatter.dateFromString(createdAtString)
            formatter.dateFormat = "h"
            timestamp = formatter.stringFromDate(date!) + "h"
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            //print("\(dictionary)\n")
            tweets.append(tweet)
        }
        
        return tweets
    }
}
