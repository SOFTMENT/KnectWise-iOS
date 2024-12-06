//
//  UserTableViewCell.swift
//  KnectWise
//
//  Created by Vijay Rathore on 06/10/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mSubtitle: UILabel!
    
    @IBOutlet weak var menuBtn: UIImageView!
    override class func awakeFromNib() {
        
    }
}
