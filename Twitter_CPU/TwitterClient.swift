//
//  TwitterClient.swift
//  Twitter_CPU
//
//  Created by christopher soria on 2/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "Blfsv7a1evn8F0bAIcTKB5Hvu"
let twitterConsumerSecret = "Dhr0k74zfaRQsGWvtBNPNLGR487JWoRz5eBaWHbRsireftpVgr"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
