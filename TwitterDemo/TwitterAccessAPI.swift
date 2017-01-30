//
//  TwitterAccessAPI.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/30/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

import Foundation
import STTwitter

class TwitterAccessAPI {
    static let TwitterAPISharedInstance = TwitterAccessAPI()
    private let twitterAPI: STTwitterAPI
    
    private init() {
    
        twitterAPI = STTwitterAPI(oAuthConsumerKey: "erRX64spTPkdyzqxbAkW9OFa1",
                                  consumerSecret: "fdys3G9u9OGqoqETty9uxcGtb64YKDaOHxHhenNCRCsoqq1qL5",
                                  oauthToken: "104355235-oBHSRpnycmA5brEQgYwwkTaRlehFneZwlMnYTxP5",
                                  oauthTokenSecret: "DvsQBTuSzsId9cH9tNKgkIziZM0c49vhkUrHtZIuoN819")
        
        twitterAPI.verifyCredentials(userSuccessBlock: {(username, userId) -> Void
            in
            print("Usuario: \(username!), ID: \(userId!)")}) {(error) -> Void in
                print(error!)
        }
        //twitterAPI = STTwitterAPI()
    }
    
    func getUserTimeLine() -> [TimeLineTweet] {
        
        var timeLine = [TimeLineTweet]()
        /*twitterAPI.getHomeTimeline(sinceID: nil, count: 1, successBlock: {(statuses) ->
            Void in
            
            for status in (statuses as? [AnyObject])! {
                let text = status["text"] as? String
                
                if let user = status["user"] as? NSDictionary {
                    let profileImage = user["profile_image_image_url_https"] as? String
                    let screenName = user["screen_name"] as? String
                    let name = user["name"] as? String
                
                    timeLine.append(TimeLineTweet(text: text, profileImageURL: profileImage, name: name, screenName: screenName))
                }
            }
            
        }, errorBlock: {(error) ->
            Void in
            print("Error Message on getting user timeline: \(error!)")
        })*/
        
        // For test purporse
        timeLine.append(TimeLineTweet(text: "Puede ser que este bloqueada la API, debido al numero de consultas", profileImageURL: "https://3.bp.blogspot.com/-JhISDA9aj1Q/UTECr1GzirI/AAAAAAAAC2o/5qmvWZiCMRQ/s1600/Twitter.png", name: "Test", screenName: "TestChocola"))
        print("API = \(timeLine.count)")
        return timeLine
    }
    
    func getUserFollowers() -> [Follower] {
        var followers = [Follower]()
        twitterAPI.getFollowersForScreenName(nil, successBlock: {(followers) ->
            Void in
            print(followers!)
            
        }, errorBlock: {(error) ->
            Void in
            print("Error Message on getting followers list: \(error!)")
        })
        
        return followers
    }
}
