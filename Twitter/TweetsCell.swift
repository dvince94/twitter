//
//  TweetsCell.swift
//  Twitter
//
//  Created by Vincent Duong on 2/21/16.
//  Copyright © 2016 Vincent Duong. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritedCountLabel: UILabel!
    var tweetID = ""
    var retweeted: Bool!
    var favorited: Bool!
    var tweets: Tweet!
    
    @IBAction func retweetButtonTapped(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweetID)
        if (!retweeted) {
            retweeted = true
            retweetCountLabel.text = "\(tweets.retweetCount + 1)"
            if let image = UIImage(named: "retweet-action-on") {
                retweetButton.setImage(image, forState: .Normal)
            }
        }
        else {
            retweeted = false
            retweetCountLabel.text = "\(tweets.retweetCount)"
            if let image = UIImage(named: "retweet-action") {
                retweetButton.setImage(image, forState: .Normal)
            }
        }
    }
    @IBAction func favoriteButtonTapped(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweetID)
        if (!favorited) {
            favorited = true
            favoritedCountLabel.text = "\(tweets.favoriteCount + 1)"
            if let image = UIImage(named: "like-action-on") {
                favButton.setImage(image, forState: .Normal)
            }
        }
        else {
            favorited = false
            favoritedCountLabel.text = "\(tweets.favoriteCount)"
            if let image = UIImage(named: "like-action") {
                favButton.setImage(image, forState: .Normal)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
        
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
        favoritedCountLabel.preferredMaxLayoutWidth = favoritedCountLabel.frame.size.width
        retweetCountLabel.preferredMaxLayoutWidth = retweetCountLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
        favoritedCountLabel.preferredMaxLayoutWidth = favoritedCountLabel.frame.size.width
        retweetCountLabel.preferredMaxLayoutWidth = retweetCountLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
