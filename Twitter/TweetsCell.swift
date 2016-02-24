//
//  Tweetsswift
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
    
    var tweet: Tweet! {
        didSet {
            //Set the tweet text
            if let tweetText = tweet.text as? String {
                tweetLabel.text = tweetText
            }
            
            //Set the time stamp
            timeStampLabel.text = tweet.timestamp!
            
            //Username
            userName.text = tweet.name!
            
            //Profile Image
            if let profileImg = tweet.profileImageURL {
                profileImage.setImageWithURL(profileImg)
            }
            else {
                //Default image if profile image is nil
                profileImage.image = UIImage(named: "Twitter_logo_blue_48")
            }
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favoritedCountLabel.text = "\(tweet.favoriteCount)"
            
            //Get the tweet id
            tweetID = tweet.tweetID!
            retweeted = tweet.retweeted!
            favorited = tweet.favorited!
            if (retweeted == false) {
                if let image = UIImage(named: "retweet-action") {
                    retweetButton.setImage(image, forState: .Normal)
                }
            }
            else {
                if let image = UIImage(named: "retweet-action-on") {
                    retweetButton.setImage(image, forState: .Normal)
                }
            }
            if (favorited == false) {
                if let image = UIImage(named: "like-action") {
                    favButton.setImage(image, forState: .Normal)
                }
            }
            else {
                if let image = UIImage(named: "like-action-on") {
                    favButton.setImage(image, forState: .Normal)
                }
            }
        }
    }
    
    @IBAction func retweetButtonTapped(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweetID)
        self.reloadInputViews()
        if (retweeted == false) {
            //retweeted = true
            retweetCountLabel.text = "\(tweet.retweetCount + 1)"
            if let image = UIImage(named: "retweet-action-on") {
                retweetButton.setImage(image, forState: .Normal)
            }
        }
        else {
            //retweeted = false
            retweetCountLabel.text = "\(tweet.retweetCount)"
            if let image = UIImage(named: "retweet-action") {
                retweetButton.setImage(image, forState: .Normal)
            }
        }
    }
    
    @IBAction func favoriteButtonTapped(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweetID)
        if (favorited == false) {
            favorited = true
            favoritedCountLabel.text = "\(tweet.favoriteCount + 1)"
            if let image = UIImage(named: "like-action-on") {
                favButton.setImage(image, forState: .Normal)
            }
        }
        else {
            favorited = false
            favoritedCountLabel.text = "\(tweet.favoriteCount)"
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
