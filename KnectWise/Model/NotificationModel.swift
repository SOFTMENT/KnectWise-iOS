//
//  NotificationModel.swift
//  KnectWise
//
//  Created by Vijay Rathore on 19/02/24.
//

import UIKit

class NotificationModel: NSObject, Codable {
    
    var title : String?
    var message : String?
    var notificationTime : Date?
    var notificationId : String?
}
