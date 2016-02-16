//
//  TweetCell.swift
//  Twitter_CPU
//
//  Created by christopher soria on 2/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweeterHandle: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var whenCreated: UILabel!
    
    var tweet: Tweet! {
        didSet {
            userName.text = "\((tweet.user?.name)!)"
            tweeterHandle.text = "@" + "\((tweet.user?.screenname)!)"
            tweetContent.text = tweet.text
            whenCreated.text = "\(tweet.createdAt!)"
            whenCreated.text = calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow)
            
            let imageUrl = tweet.user?.profileImageUrl!
            profileImage.setImageWithURL(NSURL(string: imageUrl!)!)
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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
