//
//  TweetDetailViewController.swift
//  Twitter_CPU
//
//  Created by christopher soria on 2/26/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking



class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweeterHandle: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var whenCreated: UILabel!
    @IBOutlet weak var replyField: UITextField!
    @IBOutlet weak var profileButton: UIButton!
    
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!


    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tweetImage: UIImageView!
    
    
    var tweetMessage: String = ""
    var tweet: Tweet!
    var tweetID: String = ""

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        whenCreated.text = tweet?.createdAtString
        
        let imageUrl = tweet.user?.profileImageUrl!
            profileImage.setImageWithURL(NSURL(string: imageUrl!)!)
        
        tweetContent.text = tweet?.text
        tweetContent.sizeThatFits(CGSize(width: tweetContent.frame.width, height: CGFloat.max))
        userName.text = tweet.user?.name!
        tweeterHandle.text = "@" + tweet.user!.screenname!
        
        tweetID = tweet.id
        retweetCountLabel.text = String(tweet.retweetCount!)
        favoriteCountLabel.text = String(tweet.favoriteCount!)
        
        retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
        favoriteCountLabel.text! == "0" ? (favoriteCountLabel.hidden = true) : (favoriteCountLabel.hidden = false)
        
        if tweet!.mediaURL != nil {
            tweetImage.setImageWithURL(tweet!.mediaURL!)
            tweetImage.sizeToFit()
            print("Image loaded")
            if tweet!.mediaURL == nil {
                
            }
            print("no image load")
        }
        
        //replyField.text = "@\(tweeterHandle!)"
        
        
        // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.retweetButton.setImage(UIImage(named: "retweet-action-on.png"), forState: UIControlState.Selected)
            
            if self.retweetCountLabel.text! > "0" {
                self.retweetCountLabel.text = String(self.tweet.retweetCount! + 1)
            } else {
                self.favoriteCountLabel.hidden = false
                self.favoriteCountLabel.text = String(self.tweet.favoriteCount! + 1)
                print("retweet")
                
            }
        })
    }

    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.likeTweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.favoriteButton.setImage(UIImage(named: "like-action-off.png"), forState: UIControlState.Selected)
            
            if self.favoriteCountLabel.text! > "0" {
                self.favoriteCountLabel.text = String(self.tweet.favoriteCount! + 1)
            } else {
                self.favoriteCountLabel.hidden = false
                self.favoriteCountLabel.text = String(self.tweet.favoriteCount! + 1)
                
                print("favorite")
            }
        })
    
    }
    
    @IBAction func onReply(sender: AnyObject) {
        tweetMessage = replyField.text!
        let escapedTweetMessage = tweetMessage.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        TwitterClient.sharedInstance.tweeting(escapedTweetMessage!, params: nil , completion: { (error) -> () in
            
        })
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("profile segue")
    }
    

}
