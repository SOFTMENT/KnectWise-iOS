//
//  AdminNotificationsTableViewCell.swift
//  KnectWise
//
//  Created by Vijay Rathore on 19/02/24.
//


import UIKit

class AdminNotificationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mHour: UILabel!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mMessage: UILabel!
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var deleteBtn: UIImageView!
    
    override func awakeFromNib() {
        
    }
}
