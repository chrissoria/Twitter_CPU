//
//  Tweet.swift
//  Twitter_CPU
//
//  Created by christopher soria on 2/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    //var followersCount: Int
    //var followingCount: Int
    //var statusesCount: Int
    var mediaURL: NSURL?
    var mediaURLString: String
    var media: [NSDictionary]?
    
    var retweetCount: Int?
    var favoriteCount: Int?
    var id: String
    var otherInfo: NSDictionary?
    var entities: NSDictionary?
    //var profileBackgroundURL: String
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        //followersCount = (otherInfo!["followers_count"] as? Int) ?? 0
        //followingCount = (otherInfo!["friends_count"] as? Int) ?? 0
        //statusesCount = otherInfo!["statuses_count"] as! Int
        //profileBackgroundURL = (otherInfo!["profile_banner_url"] as? String)!
       
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z Y"
        createdAt = formatter.dateFromString(createdAtString!)
        otherInfo = dictionary["user"] as! NSDictionary?
        
        id = String (dictionary["id"]!)
        retweetCount = dictionary["retweet_count"] as? Int
        favoriteCount = dictionary["favorite_count"] as? Int
        
        mediaURLString = ""

        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }

}
