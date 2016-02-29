//
//  TweetCell.swift
//  Twitter_CPU
//
//  Created by christopher soria on 2/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweeterHandle: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var whenCreated: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!

    
    var tweetID: String = ""
    
    
    var tweet: Tweet! {
        didSet {
            userName.text = "\((tweet.user?.name)!)"
            tweeterHandle.text = "@" + "\((tweet.user?.screenname)!)"
            tweetContent.text = tweet.text
            whenCreated.text = "\(tweet.createdAt!)"
            whenCreated.text = calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow)
            
            let imageUrl = tweet.user?.profileImageUrl!
            profileImage.setImageWithURL(NSURL(string: imageUrl!)!)
            
            //retweetCountLabel.text = String(tweet.retweetCount!)
            //favoriteCountLabel.text = String(tweet.retweetCount!)
            
            //retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
            
            //favoriteCountLabel.text! == "0" ? (favoriteCountLabel.hidden = true) : (favoriteCountLabel.hidden = false)
            
            tweetID = tweet.id
            retweetCountLabel.text = String(tweet.retweetCount!)
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            
            retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
            favoriteCountLabel.text! == "0" ? (favoriteCountLabel.hidden = true) : (favoriteCountLabel.hidden = false)
            
        }
    
    }
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        if (rawTime <= 60) {
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) {
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) {
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) {
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) { 
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
        
        tweetContent.preferredMaxLayoutWidth = tweetContent.frame.size.width
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tweetContent.preferredMaxLayoutWidth = tweetContent.frame.size.width
    }
    


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.retweetButton.setImage(UIImage(named: "retweet-action-on.png"), forState: UIControlState.Selected)
            
            if self.retweetCountLabel.text! > "0" {
                self.retweetCountLabel.text = String(self.tweet.retweetCount! + 1)
            } else {
                self.favoriteCountLabel.hidden = false
                self.favoriteCountLabel.text = String(self.tweet.favoriteCount! + 1)
        
            }
        })
    }
    
    
    @IBAction func onLike(sender: AnyObject) {
        TwitterClient.sharedInstance.likeTweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.favoriteButton.setImage(UIImage(named: "like-action-off.png"), forState: UIControlState.Selected)
            
            if self.favoriteCountLabel.text! > "0" {
                self.favoriteCountLabel.text = String(self.tweet.favoriteCount! + 1)
            } else {
                self.favoriteCountLabel.hidden = false
                self.favoriteCountLabel.text = String(self.tweet.favoriteCount! + 1)
            }
        })
    }
    


}
