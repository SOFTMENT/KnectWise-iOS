//
//  HomeViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 05/01/24.
//

import UIKit

class HomeViewController : UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var fullName: UILabel!
    
    override func viewDidLoad() {
        
        guard let userModel = UserModel.data else {
            
            DispatchQueue.main.async {
                self.beRootScreen(mIdentifier: Constants.StroyBoard.signInViewController)
            }
            return
            
        }
        
        profilePic.layer.cornerRadius = profilePic.bounds.height / 2
        if let path = userModel.profilePic, !path.isEmpty {
            profilePic.sd_setImage(with: URL(string: path), placeholderImage: UIImage(named: "profile-placeholder"))
        }
        
        fullName.text = "Hi, \(userModel.fullName ?? "")"
        filterView.layer.cornerRadius = 8
        
        filterView.isUserInteractionEnabled = true
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterBtnClicked)))
        
    }
    
    @objc func filterBtnClicked(){
        
    }
}
