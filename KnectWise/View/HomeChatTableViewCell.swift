//
//  HomeChatTableViewCell.swift
//  KnectWise
//
//  Created by Vijay Rathore on 17/10/24.
//

import UIKit

class HomeChatTableViewCell: UITableViewCell {
  
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet var mTitle: UILabel!
    @IBOutlet var mLastMessage: UILabel!
    @IBOutlet var mTime: UILabel!
    @IBOutlet var mView: UIView!

    override func prepareForReuse() {
        self.mImage.image = nil
    }
}
