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
            whenCreated.text = "\(tweet.createdAt)"
            
            let imageUrl = tweet.user?.profileImageUrl!
            profileImage.setImageWithURL(NSURL(string: imageUrl!)!)
        }
    
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
