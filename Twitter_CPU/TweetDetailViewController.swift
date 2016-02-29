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
    
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    

    var tweet: Tweet!
    var tweetID: NSNumber?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        whenCreated.text = tweet?.createdAtString
        do {
            let imageUrl = tweet.user?.profileImageUrl!
            profileImage.setImageWithURL(NSURL(string: imageUrl!)!)
        
        }
        
        tweetContent.text = tweet?.text
        tweetContent.sizeThatFits(CGSize(width: tweetContent.frame.width, height: CGFloat.max))
        userName.text = tweet.user?.name!
        tweeterHandle.text = "@" + tweet.user!.screenname!
        
       // tweetID = tweet.id!
        //retweetCountLabel.text = String(tweet.retweetTotal!)
       // favCountLabel.text = String(tweet.favCount!)
        
        
       // retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
        //favCountLabel.text! == "0" ? (favCountLabel.hidden = true) : (favCountLabel.hidden = false)
        
        //tweetID = tweet.id
        
        
        // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
