//
//  TwitterAccessAPI.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/30/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

/* Class used to encapsulate all the calls to the Twitter API and the means to 
   interact with the API, also implement the Singleton desing pattern.
 */

import Foundation
import STTwitter

class TwitterAccessAPI {
    static let TwitterAPISharedInstance = TwitterAccessAPI()
    private let twitterAPI: STTwitterAPI
    private var delegate: DataReceivedDelegate? = nil
    
    // Initialize the class and set the parameters for calling the API endpoints
    
    private init() {
    
        var format = PropertyListSerialization.PropertyListFormat.xml
        var pListAPIKeys: [String:String] = [:]
        let pListPath: String? = Bundle.main.path(forResource: "TwitterAPIKeys", ofType: "plist")!
        let pListXML = FileManager.default.contents(atPath: pListPath!)!
        
        do {
            pListAPIKeys = try PropertyListSerialization.propertyList(from: pListXML, options: .mutableContainersAndLeaves, format: &format) as! [String:String]
        } catch {
            print("Error reading TwitterAPIKeys.plist: \(error), format: \(format)")
        }
        
        let oAuthConsumerKey = pListAPIKeys["oAuthConsumerKey"]
        let consumerSecret = pListAPIKeys["consumerSecret"]
        let oauthToken = pListAPIKeys["oauthToken"]
        let oauthTokenSecret = pListAPIKeys["oauthTokenSecret"]
        
        twitterAPI = STTwitterAPI(oAuthConsumerKey: oAuthConsumerKey,
                                  consumerSecret: consumerSecret,
                                  oauthToken: oauthToken,
                                  oauthTokenSecret: oauthTokenSecret)
        
        twitterAPI.verifyCredentials(userSuccessBlock: {(username, userId) -> Void
            in
            print("Usuario: \(username!), ID: \(userId!)")}) {(error) -> Void in
                print(error!)
        }
    }
    
    // Method used to get the user timeline
    
    func getUserTimeLine(viewController: DataReceivedDelegate) {
        self.delegate = viewController
        var timeLine = [TimeLineTweet]()

        twitterAPI.getHomeTimeline(sinceID: nil, count: 15, successBlock: {(statuses) ->
            Void in
            for status in (statuses as? [AnyObject])! {
                let text = status["text"] as? String
                
                if let user = status["user"] as? NSDictionary {
                    let tweetID = user["id_str"] as? String
                    let profileImage = user["profile_image_url_https"] as? String
                    let screenName = user["screen_name"] as? String
                    let name = user["name"] as? String
                
                    timeLine.append(TimeLineTweet(id: tweetID, text: text, profileImageURL: profileImage, name: name, screenName: screenName))
                }
            }
            
            if (self.delegate != nil) {
                self.delegate!.setDataSource(list: timeLine)
            }
        
        }, errorBlock: {(error) ->
            Void in
            print("Error Message on getting user timeline: \(error!.localizedDescription)")
        })
    }
    
    // Method for get the followers of the user
    
    func getUserFollowers(viewControler: FollowersViewController) {
        self.delegate = viewControler
        var followersList = [Follower]()
        twitterAPI.getFollowersForScreenName(twitterAPI.userName, successBlock: {(followers) ->
            Void in
            //print(followers!)
            for follower in (followers as? [AnyObject])! {
                let name = follower["name"] as? String
                let screenName = follower["screen_name"] as? String
                let profileImage = follower["profile_image_url_https"] as? String
                
                followersList.append(Follower(name: name, screenName: screenName, profileImageURL: profileImage))
            }
            
            if (self.delegate != nil) {
                self.delegate!.setDataSource(list: followersList)
            }
            
        }, errorBlock: {(error) ->
            Void in
            print("Error Message on getting followers list: \(error!.localizedDescription)")
        })
    }
    
    func publishTweetWithCoordinates(status: String, latitude: Double, longitude: Double) {
        self.postUpdateStatus(status: status, latitude: latitude, longitude: longitude)
    }
    
    func publishTweet(status: String) {
        self.postUpdateStatus(status: status, latitude: 0.0, longitude: 0.0)
    }
    
    // Method used to post a new tweet ot status
    
    func postUpdateStatus(status: String, latitude: Double, longitude: Double) {
        
        let lat = String(format: "%f", latitude)
        let lon = String(format: "%f", longitude)
        var showCoordinates = NSNumber(value: 0)
        
        if (latitude != 0.0 && longitude != 0.0) {
            showCoordinates = 1
        }
        
        twitterAPI.postStatusesUpdate(status, inReplyToStatusID: nil, mediaIDs: nil, latitude: lat, longitude: lon,
                                      placeID: nil, displayCoordinates: showCoordinates, trimUser: 0, autoPopulateReplyMetadata: 0,
                                      excludeReplyUserIDsStrings: nil, attachmentURLString: nil, useExtendedTweetMode: 0,
                                      successBlock: {(success) -> Void in }, errorBlock: {(error) ->
                                        Void in
                                        print("Error Message updating the status: \(error!.localizedDescription)")
        })
    }
}
