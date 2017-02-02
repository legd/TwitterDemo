//
//  PublishViewController.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/30/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

/* Class for managing the process of posting a tweet and getting the current location 
   of the user.
 */

import UIKit
import CoreLocation

class PublishViewController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var switchLocation: UISwitch!
    let locationManeger = CLLocationManager()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.textColor = UIColor.lightGray
        tweetText.text = "What are you thinking?"
        switchLocation.setOn(false, animated: false)
        
        locationManeger.delegate = self
        locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func publishTweet(_ sender: UIButton) {
       
        guard let text = self.tweetText.text, text != "What are you thinking?" else {
            let alert = UIAlertController(title: "Alert",
                                          message: "You cannot post an empty tweet!",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let twitter = TwitterAccessAPI.TwitterAPISharedInstance
        
        if switchLocation.isOn {
            twitter.publishTweetWithCoordinates(status: text, latitude: self.latitude, longitude: self.longitude)
        } else {
            twitter.publishTweet(status: text)
        }
        
        self.tabBarController?.selectedIndex = 0
    }
    
    func setCurrentLocation(placemark: CLPlacemark) {
        self.locationManeger.stopUpdatingLocation()
        self.latitude = (placemark.location?.coordinate.latitude)!
        self.longitude = (placemark.location?.coordinate.longitude)!
    }

    // MARK: - Protocols implementations

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (tweetText.text.isEmpty || tweetText.text == "") {
            tweetText.textColor = UIColor.lightGray
            tweetText.text = "What are you thinking?"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Reverser geocoder failed with error \(error?.localizedDescription)")
                return
            }
            
            if (placemarks?.count)! > 0 {
                let placemark = (placemarks?[0])! as CLPlacemark
                self.setCurrentLocation(placemark: placemark)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location \(error.localizedDescription)")
    }

}
