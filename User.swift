//
//  User.swift
//  Twitter_CPU
//
//  Created by christopher soria on 2/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "KCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    var profileURL: NSURL
    var statusesCount: Int
    var followersCount: Int
    var followingCount: Int
    var userID: Int
    var bannerImageUrl: NSURL?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        profileURL = NSURL(string: profileImageUrl!)!
        userID = dictionary["id"] as! Int
        followersCount = (dictionary["followers_count"] as? Int)!
        followingCount = (dictionary["friends_count"] as? Int)!
        statusesCount = dictionary["statuses_count"] as! Int
        
        let banner = dictionary["profile_banner_url"] as? String
        if banner != nil {
            bannerImageUrl = NSURL(string: banner!)!
        }

        
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                //logged out or just boot up
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    let dictionary: NSDictionary?
                    do {
                        try dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                        _currentUser = User(dictionary: dictionary!)
                    } catch {
                        print(error)

                
        
                    }
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if (_currentUser != nil) {
                do {
                    // if current user is not nil, change it to the JSON serialized string
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions.PrettyPrinted)
                    // store it in the key
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                    //  save (write or flush) it to disk
                    NSUserDefaults.standardUserDefaults().synchronize()
                } catch (let error) {
                    print(error)
                    // even if it's nil you still want to clear it
                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                    NSUserDefaults.standardUserDefaults().synchronize()


                }

            }
            
        }
    }
    
}
