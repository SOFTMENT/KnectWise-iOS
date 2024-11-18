//
//  AllMessageModel.swift
//  KnectWise
//
//  Created by Vijay Rathore on 18/10/24.
//

import UIKit

class AllMessageModel: NSObject, Codable {
    // MARK: Lifecycle

    override init() {}

    // MARK: Internal

    var senderUid: String?
    var message: String?
    var messageID: String?
    var date: Date?
}
