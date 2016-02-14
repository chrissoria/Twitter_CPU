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

class User: NSObject {
    var name: String?
    var screename: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screename = dictionary["scree_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
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
            //User need to implement NSCoding; but, JSON also serialized by default
            if let _ = _currentUser {
                var data: NSData?
                do {
                    try data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: .PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    print(error)

                }

            }
            
        }
    }
    
}
