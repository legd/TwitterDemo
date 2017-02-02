//
//  TimeLineViewController.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/30/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

/* This class manage all the task related with the user timeline
 */

import UIKit

// Struct used as a model for the tweets
struct TimeLineTweet {
    var id: String?
    var text: String?
    var profileImageURL: String?
    var name: String?
    var screenName: String?
}

class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataReceivedDelegate {

    @IBOutlet weak var tweets: UITableView!
    var timeLineTweets = [TimeLineTweet]()
    
    var customActivityIndicator = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var indicatorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweets.dataSource = self
        tweets.delegate = self
        
        let twitter = TwitterAccessAPI.TwitterAPISharedInstance
        twitter.getUserTimeLine(viewController: self)
        
        self.displayCustomActivityIndicator(msg: "Cargando Tweets", indicator: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCustomActivityIndicator(msg:String, indicator:Bool ) {
        indicatorLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        indicatorLabel.text = msg
        indicatorLabel.textColor = UIColor.white
        customActivityIndicator = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        customActivityIndicator.layer.cornerRadius = 15
        customActivityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            customActivityIndicator.addSubview(activityIndicator)
        }
        customActivityIndicator.addSubview(indicatorLabel)
        view.addSubview(customActivityIndicator)
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
                self.customActivityIndicator.removeFromSuperview()
            }
        }
        
        cell.tweetText.text = "\(self.timeLineTweets[indexPath.item].screenName!) \n \(self.timeLineTweets[indexPath.item].text!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 //tal vez 80
    }
    
    func setDataSource<T>(list: [T]) {
        let firstTweet = list[0] as! TimeLineTweet
        
        var index = 0
        
        if (self.timeLineTweets.count == 0 || firstTweet.id != self.timeLineTweets[0].id) {
            while (index < list.count) {
                self.timeLineTweets.append(list[index] as! TimeLineTweet)
                index += 1
            }
            
            self.tweets.reloadData()
        }
        
    }


}
