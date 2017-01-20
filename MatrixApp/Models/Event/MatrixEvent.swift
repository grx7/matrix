//
//  MatrixEvent.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 20/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import MatrixSDK

class MatrixEvent {
    
    var event: MXEvent
    var eventFormatter: MatrixEventFormatter
    
    init(event: MXEvent) {
        self.event = event
        self.eventFormatter = MatrixEventFormatter(event: event)
    }
    
    func timeAgo() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.event.ageLocalTs / 1000))
        
        return date.timeAgo().lowercased()
    }
    
    func asString() -> String {
        return self.eventFormatter.formattedEvent()
    }

}
