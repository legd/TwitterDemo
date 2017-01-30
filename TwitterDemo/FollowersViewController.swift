//
//  FollowersViewController.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/30/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

import UIKit

struct Follower {
    var name: String?
    var screenName: String?
    var profileImageURL: String?
}

class FollowersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var followers: UITableView!
    var followersList = [Follower]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followers.dataSource = self
        followers.delegate = self
        
        let twitter = TwitterAccessAPI.TwitterAPISharedInstance
        followersList.append(contentsOf: twitter.getUserFollowers())
        
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
        return self.followersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowerTableViewCell = self.followers.dequeueReusableCell(withIdentifier: "FollowerCell") as! FollowerTableViewCell
        
        let url = URL(string: self.followersList[indexPath.item].profileImageURL!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.profileImage.image = UIImage(data: data!)
            }
        }
        
        cell.name.text = self.followersList[indexPath.item].name!
        cell.screenName.text = self.followersList[indexPath.item].screenName!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
