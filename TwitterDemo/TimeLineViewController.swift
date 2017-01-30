//
//  TimeLineViewController.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/30/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

import UIKit

struct TimeLineTweet {
    var text: String?
    var profileImageURL: String?
    var name: String?
    var screenName: String?
}

class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tweets: UITableView!
    var timeLineTweets = [TimeLineTweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let tableView = UITableView()
        view.addSubview(tableView)
        self.tweets = tableView*/
        
        tweets.dataSource = self
        tweets.delegate = self
        
        let twitter = TwitterAccessAPI.TwitterAPISharedInstance
        timeLineTweets.append(contentsOf: twitter.getUserTimeLine())
        
        print("VC = \(self.timeLineTweets.count)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Protocols implementations
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeLineTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TweetTableViewCell = self.tweets.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetTableViewCell
        
        let url = URL(string: self.timeLineTweets[indexPath.item].profileImageURL!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.profileImage.image = UIImage(data: data!)
            }
        }
        
        cell.tweetText.text = "\(self.timeLineTweets[indexPath.item].screenName!) \n \(self.timeLineTweets[indexPath.item].text!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 //tal vez 80
    }

}
