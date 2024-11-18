//
//  LastMessageModel.swift
//  KnectWise
//
//  Created by Vijay Rathore on 17/10/24.
//
import UIKit

class LastMessageModel: NSObject, Codable {
    // MARK: Lifecycle

    override init() {}

    // MARK: Internal

    var senderUid: String?
    var date: Date?
    var senderImage: String?
    var senderName: String?
    var senderToken: String?
    var message: String?
   
}
