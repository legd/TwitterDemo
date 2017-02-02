//
//  FollowersViewController.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/30/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

/* Class in charge for getting the list of follower and show it
 */

import UIKit

// struct used as a model for the followers
struct Follower {
    var name: String?
    var screenName: String?
    var profileImageURL: String?
}

class FollowersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataReceivedDelegate {
    
    @IBOutlet weak var followers: UITableView!
    var followersList = [Follower]()
    
    var customActivityIndicator = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var indicatorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followers.dataSource = self
        followers.delegate = self
        
        let twitter = TwitterAccessAPI.TwitterAPISharedInstance
        twitter.getUserFollowers(viewControler: self)
        
        self.displayCustomActivityIndicator(msg: "Cargando seguidores", indicator: true)
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
        return self.followersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowerTableViewCell = self.followers.dequeueReusableCell(withIdentifier: "FollowerCell") as! FollowerTableViewCell
        
        let url = URL(string: self.followersList[indexPath.item].profileImageURL!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.profileImage.image = UIImage(data: data!)
                self.customActivityIndicator.removeFromSuperview()
            }
        }
        
        cell.name.text = self.followersList[indexPath.item].name!
        cell.screenName.text = self.followersList[indexPath.item].screenName!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func setDataSource<T>(list: [T]) {
        var index = 0
        
        while (index < list.count) {
            self.followersList.append(list[index] as! Follower)
            index += 1
        }
        
        self.followers.reloadData()
    }
    
}
