//
//  Global.swift
//  CommentViewer
//
//  Created by Gökhan Mandacı on 26.06.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit
import AlamofireImage

let notiDismissCell = Notification.Name(rawValue: "notiDismissCell")

let dlImageCache = AutoPurgingImageCache(
    memoryCapacity: 250_000_000,
    preferredMemoryUsageAfterPurge: 210_000_000
)
let imageDownloader = ImageDownloader(configuration: ImageDownloader.defaultURLSessionConfiguration(), downloadPrioritization: ImageDownloader.DownloadPrioritization.lifo, maximumActiveDownloads: 4, imageCache: AutoPurgingImageCache())

/// Holds device width
var deviceWidth = 0
/// Holds device height
var deviceHeight = 0

/**
 Gets device width
 
 - Returns: CGFLoat
 */
func getWidth() -> CGFloat {
    return CGFloat(deviceWidth)
}

/**
 Gets device height
 
 - Returns: CGFLoat
 */
func getHeight() -> CGFloat {
    return CGFloat(deviceHeight)
}

/**
 Sets deviceWidth and deviceHeight parameters for further use.
 
 ## Important ##
 * Use this function in the first view controller's didLoad funtion.
 
 - Parameter width: Device width
 - Parameter height: Device height
 
 ### Usage Example: ###
 ````
 setDeviceBounds(Int(self.view.bounds.width), height: Int(self.view.bounds.height))
 ````
 
 - Returns: None.
 */
func setDeviceBounds(_ width: Int, height: Int) {
    deviceWidth = width
    deviceHeight = height
}

/**
 Formats and calculates time from your date string to now.
 
 - Parameter date: String date from server
 
 ### Usage Example: ###
 ````
 label.text = calculateBackDays("dateStringFromServer")
 ````
 
 - Returns: Back days string.
 */
func calculateBackDays(_ date: String) -> String {
    let now = Date()
    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: now))
    print(timeZoneOffset)
    let timeZoneOffSetHours = timeZoneOffset / 3600
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .iso8601)
    if date.contains(".") {
        let dd = date
        let ddd = dd.split(separator: ".")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let createDate = dateFormatter.date(from: String(ddd[0]))
        if let createDateToOffset = createDate {
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.day, .hour, .minute, .second], from: createDateToOffset, to: now)
            return backDaysString(components, Int(timeZoneOffSetHours))
        } else {
            return ""
        }
    } else {
        return ""
    }
}

/**
 Helper function for calculateBackDays function.
 
 - Parameter components: Calendar components
 - Parameter timeZoneOffset: Current offset
 
 - Returns: Back days string.
 */
func backDaysString(_ components: DateComponents, _ timeZoneOffset: Int) -> String {
    if let days = components.day {
        if days < 30 {
            if days < 1 {
                if let hours = components.hour {
                    if hours - timeZoneOffset < 1 {
                        if let minutes = components.minute {
                            if minutes < 1 {
                                if let secs = components.second {
                                    if secs == 0 {
                                        return "now"
                                    }
                                    return "\(secs) sec. ago"
                                } else {
                                    return "\(minutes) min. ago"
                                }
                            } else {
                                return "\(minutes) min. ago"
                            }
                        } else {
                            if hours == 1 {
                                return "\(hours) hour ago"
                            }
                            return "\(hours) hours ago"
                        }
                    } else {
                        if hours == 1 {
                            return "\(hours) hour ago"
                        }
                        return "\(hours) hours ago"
                    }
                } else {
                    if days == 1 {
                        return "\(days) day ago"
                    }
                    return "\(days) days ago"
                }
            } else {
                if days == 1 {
                    return "\(days) day ago"
                }
                return "\(days) days ago"
            }
        } else {
            let months: Int = days / 30
            if months > 1 {
                return "\(months) months"
            }
            return "1 month"
        }
    } else {
        return ""
    }
}

/**
 Delays the operation in it.
 
 - Parameter seconds: Delay duration in seconds.
 - Parameter fn: Completion function
 
 ### Usage Example: ###
 ````
 delay(0.4){
 *Operation in here will be executed after 0.4 seconds reading function.*
 }
 ````
 
 - Returns: None.
 */
func delay(_ seconds: Double, fn: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(seconds * 1000.0)), execute: fn)
}
