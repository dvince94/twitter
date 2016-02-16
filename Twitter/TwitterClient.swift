//
//  TwitterClient.swift
//  Twitter
//
//  Created by Vincent Duong on 2/15/16.
//  Copyright © 2016 Vincent Duong. All rights reserved.
//

import UIKit

let twitterConsumerKey = "TkSCzKvwloQ0ejW9w7VOq7MRd"
let twitterConsumerSecret = "nk20lRDVNqzlV1TsbVoVCRpN5tlNIn5BdKcsi1mYmFFVBHyxTJ"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
