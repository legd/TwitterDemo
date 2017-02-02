//
//  DataReceivedDelegate.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/31/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

/* Protocol use to update data in the main thread from an async task
 */

import Foundation

protocol DataReceivedDelegate {
    func setDataSource<T>(list: [T])
}
