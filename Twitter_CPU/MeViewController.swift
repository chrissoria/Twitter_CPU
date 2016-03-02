//
//  MeViewController.swift
//  Twitter_CPU
//
//  Created by christopher soria on 3/1/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!

    var tweetMessage: String = ""
    var tweet: Tweet!
    var tweetID: String = ""
    var user: User?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrl = User.currentUser!.profileImageUrl!
        profileImage.setImageWithURL(NSURL(string: imageUrl)!)
        
        followerCountLabel.text = String(User.currentUser!.followersCount)
        
        followingCountLabel.text = String(User.currentUser!.followingCount)
        tweetsCountLabel.text = String(User.currentUser!.statusesCount)
        if (User.currentUser!.bannerImageUrl != nil){
            headerImage.setImageWithURL((User.currentUser!.bannerImageUrl!))
        } else {
            print("no pic")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
