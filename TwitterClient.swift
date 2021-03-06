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

class TwitterClient: BDBOAuth1SessionManager {
    
        var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    
        
        class var sharedInstance: TwitterClient{
            struct Static{
                static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            }
            return Static.instance
        }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: ([Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response:AnyObject) -> Void in
            //print("home timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets, error: nil)
            
        }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
            print("getting error for home timeline")
            completion(nil, error: error)
            
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //Fetch Request Token and redirect to authorization page
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterchris://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
        }) { (error: NSError!) -> Void in
            print("failed to request token")
            self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject) -> Void in
                //print("user: \(response)")
                
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("getting error for current user")
                self.loginCompletion?(user: nil, error: error)
            })

        }) { (error: NSError!) -> Void in
            print("failed to get the access token")
            self.loginCompletion?(user: nil, error: error)
        }

    }
    
    func retweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Retweeted tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't retweet")
                completion(error: error)
            }
        )
    }
    func likeTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Liked tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't like tweet")
                completion(error: error)
            }
        )}
    
    func tweeting(escapedTweet: String, params: NSDictionary?, completion: (error: NSError?) -> () ){
            POST("1.1/statuses/update.json?status=\(escapedTweet)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                print("tweeted: \(escapedTweet)")
                completion(error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("Couldn't tweet")
                    completion(error: error)
            }
        )}
    
    
    func getUserTweets(name: String, params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?)  -> ()) {
        
        GET("/1.1/statuses/user_timeline.json?screen_name=\(name)&count=25", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("user's tweets: \(response)")
            let tweets = Tweet.tweetsWithArray((response as? [NSDictionary])!)
            completion(tweets: tweets, error: nil)
            
            for tweet in tweets {
                //print("text: \(tweet.text), created: \(tweet.createdAt), profileImageURL: \(tweet.profileURL)")
            }
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting user's tweets", error)
                completion(tweets: nil, error: error)
        })
        
    }
}
