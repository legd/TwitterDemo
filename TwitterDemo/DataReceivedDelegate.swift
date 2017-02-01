//
//  DataReceivedDelegate.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/31/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

import Foundation

protocol DataReceivedDelegate {
    //func setDataSource(list: [TimeLineTweet])
    func setDataSource<T>(list: [T])
}
