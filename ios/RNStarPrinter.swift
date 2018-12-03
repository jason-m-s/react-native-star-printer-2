//
//  RNStarPrinter.swift
//  RNStarPrinter
//
//  Created by Apptizer on 11/9/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

@objc(RNStarPrinter)
class RNStarPrinter: NSObject {
    
    @objc(addEvent:location:date:)
    func addEvent(name: String, location: String, date: NSNumber) -> Void {
        //add event
    }
    
    @objc
    func constantsToExport() -> [String: Any]! {
        return ["someKey": "someValue"]
    }
}
